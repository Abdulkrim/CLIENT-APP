import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/core/notifications/pushy_service.dart';
import 'package:merchant_dashboard/core/utils/failure.dart';
import 'package:merchant_dashboard/feature/auth/data/data_sources/login_local_datasource.dart';
import 'package:merchant_dashboard/feature/main_screen/data/models/entity/branch_general_info.dart';
import 'package:merchant_dashboard/feature/device/presentation/blocs/device_cubit.dart';
import 'package:merchant_dashboard/feature/main_screen/data/models/entity/merchant_info.dart';
import 'package:merchant_dashboard/feature/main_screen/data/models/menu_model.dart';
import 'package:merchant_dashboard/feature/main_screen/data/repository/main_repository.dart';
import 'package:merchant_dashboard/feature/main_screen/presentation/blocs/menu_drawer/menu_drawer_cubit.dart';
import 'package:merchant_dashboard/feature/manage_features/presentation/blocs/cubit/manage_feautre_cubit.dart';
import 'package:merchant_dashboard/feature/products/data/repository/product_repository.dart';
import 'package:merchant_dashboard/injection.dart';

import '../../../products/data/models/entity/measure_unit.dart';
import '../pages/main_screen.dart';

part 'main_screen_event.dart';

part 'main_screen_state.dart';

@Singleton()
class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  final IMainRepository _mainRepository;
  final ILoginLocalDataSource _localDataSource;
  final IProductRepository _productRepository;

  MerchantInfo selectedMerchantBranch = const MerchantInfo.firstItem();
  List<MerchantInfo> merchantItems = [];

  /// LoggedIn user datta
  MerchantInfo? loggedInMerchantInfo;

  /// Can be loggedIn user role or selected branch role and UI changes based on this.
  bool isUserBranch = false;

  List<MeasureUnit> measureUnits = [];

  BranchGeneralInfo? branchGeneralInfo;

  MainScreenBloc(this._mainRepository, this._localDataSource, this._productRepository) : super(MainScreenInitial()) {
    on<InitalEventsCall>((event, emit) {
      add(const ConfigureDashboardBasedOnUserLevelEvent());

      add(const GetGeneralBranchInfoEvent());
      add(const GetMeasureUnits());

      getIt<DeviceCubit>().checkBranchHasDevice();
    });

    on<GetGeneralBranchInfoEvent>((event, emit) async {
      emit(const BranchGeneralInfoState(isLoading: true));
      final result = await _mainRepository.getBranchGeneralInfo();
      result.fold((left) {}, (right) {
        branchGeneralInfo = right;
        if (!branchGeneralInfo!.isRestaurants) {}

        emit(const BranchGeneralInfoState(isSuccess: true));
      });
    });

    on<GetMeasureUnits>((event, emit) async {
      final Either<Failure, List<MeasureUnit>> result = await _productRepository.getMeasureUnits();

      result.fold((left) {
        debugPrint('offer error: ${left.errorMessage}');
      }, (right) {
        measureUnits = right;
        emit(GetMeasureUnitsSuccess(measureUnits));
      });
    });

    on<ConfigureDashboardBasedOnUserLevelEvent>((event, emit) {
      isUserBranch = !_localDataSource.isLoggedInUserBusiness(); // todo: optimize these

      /// Display setup guide only if logged in user isn't branch and user hasn't created branch
      showSetupGuide(!isUserBranch && !_localDataSource.hasBranch());

      loggedInMerchantInfo = _mainRepository.getLoggedInUserInfo();
      add(const MerchantInfoRequestEvent());

      if (!loggedInMerchantInfo!.isLoggedInUserG) {
        getIt<MenuDrawerCubit>().removeFromMenuList(menuItemKey: MenuModel.systemManagementSubscription);
      }

      _mainRepository.setSentryScope();

      emit(LoggedInUserInfoSuccessState(loggedInMerchantInfo!));
    });

    on<MerchantInfoRequestEvent>((event, emit) async {
      if (loggedInMerchantInfo?.isLoggedInUserG ?? false) {
        final Either<Failure, List<MerchantInfo>> merchantInfo = await _mainRepository.getMerchantInfo();

        merchantInfo.fold((left) {}, (right) {
          selectedMerchantBranch = const MerchantInfo.firstItem();
          merchantItems = [selectedMerchantBranch, ...right];

          String savedMerchantId = _mainRepository.getSelectedMerchantId();

          if (savedMerchantId.isNotEmpty) {
            selectedMerchantBranch = right.firstWhere(
              (element) => element.merchantId == savedMerchantId,
              orElse: () => const MerchantInfo.firstItem(),
            );
          } else if (right.length == 1) {
            add(MerchantSelectedChangedEvent(right.first));
          }

          isUserBranch = !selectedMerchantBranch.isLoggedInUserG;

          if (isUserBranch) getIt<ManageFeautreCubit>().getUserCurrentPlanFeatures();

          emit(MerchantInfoDataSuccessState(right));
        });
      } else {
        getIt<ManageFeautreCubit>().getUserCurrentPlanFeatures();
      }
    });

    on<ManualBranchSelectionEvent>((event, emit) {
      if (event.isReset != null && event.isReset!) {
        add(const MerchantSelectedChangedEvent(MerchantInfo.firstItem()));
      } else if (event.forceItemSelection != null && event.forceItemSelection! && merchantItems.length > 1) {
        add(MerchantSelectedChangedEvent(merchantItems.firstWhere((element) => element.merchantId != '0')));
      }
    });

    on<MerchantSelectedChangedEvent>(
      (event, emit) {
        _localDataSource.setSelectedMerchantId(merchantId: event.merchantInfo.merchantId);
        selectedMerchantBranch = event.merchantInfo;

        isUserBranch = !event.merchantInfo.isLoggedInUserG;

        if (selectedMerchantBranch.hasData) {
          add(const GetGeneralBranchInfoEvent());
          getIt<ManageFeautreCubit>().getUserCurrentPlanFeatures();
        }

        emit(MerchantInfoSelectionChangedState(event.merchantInfo));
      },
    );
  }

  _resetMainData() {
    selectedMerchantBranch = const MerchantInfo.firstItem();

    getIt<MenuDrawerCubit>().clearData();

    merchantItems = [];
    loggedInMerchantInfo = null;
  }

  void logOutUser() {
    PushyService.pushyUnSubscribeToOrderManagementTopic(selectedMerchantBranch.merchantId);
    _resetMainData();
    _mainRepository.logOutUser();
  }

  bool showSelectedBranchClearBtn() =>
      (merchantItems.isNotEmpty) && selectedMerchantBranch.merchantId != merchantItems.first.merchantId;
}
