import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/core/bloc_base_state/pagination_state.dart';
import 'package:merchant_dashboard/core/constants/defaults.dart';
import 'package:merchant_dashboard/core/utils/failure.dart';
import 'package:merchant_dashboard/feature/cashiers/data/models/entity/cashier.dart';
import 'package:merchant_dashboard/feature/cashiers/data/models/entity/cashier_role.dart';
import 'package:merchant_dashboard/feature/cashiers/data/models/entity/cashier_sort_type.dart';
import 'package:merchant_dashboard/feature/cashiers/data/repository/cashier_repository.dart';
import 'package:merchant_dashboard/utils/mixins/date_time_utilities.dart';

import '../../../../injection.dart';
import '../../../main_screen/presentation/blocs/main_screen_bloc.dart';

part 'cashier_event.dart';

part 'cashier_state.dart';

@injectable
class CashierBloc extends Bloc<CashierEvent, CashierState> with DateTimeUtilities {
  final ICashierRepository _cashierRepository;

  List<CashierSortTypes> sortType = [
    CashierSortTypes('Sales : High to Low', Defaults.sortFiledSales, Defaults.sortTypeDESC),
    CashierSortTypes('Sales : Low to High', Defaults.sortFiledSales, Defaults.sortTypeASC),
  ];

  late CashierSortTypes _selectedSortType = sortType.first;

  CashierSortTypes get selectedSortType => _selectedSortType;

  set selectedSortType(CashierSortTypes? value) {
    if (value != null) _selectedSortType = value;
  }

  String fromDate = Defaults.startDateRange;

  set _fromDate(String? val) {
    if (val != null) fromDate = val;
  }

  String toDate = Defaults.endDateRange;

  set _toDate(String? val) {
    if (val != null) toDate = val;
  }

  int selectedTabPos = 0;

  List<CashierRole> cashierRoles = [];

  final PaginationState<Cashier> cashierPagination = PaginationState<Cashier>();
  final PaginationState<Cashier> salesPagination = PaginationState<Cashier>();


  CashierBloc(this._cashierRepository) : super(CashierInitial()) {
    getIt<MainScreenBloc>().stream.listen((state) {
      if (state is MerchantInfoSelectionChangedState && state.merchantInfo.hasData) {
        add(const GetAllCashiersEvent.refresh());
        add(const GetAllCashiersSalesEvent());
      }
    });

    on<GetAllCashiersEvent>((event, emit) async {
      if (!event.getMore) {
        cashierPagination.dispose();
      } else if (cashierPagination.onFetching) {
        return;
      }
      if (cashierPagination.hasMore) {
        if (cashierPagination.currentPage == 1) emit(const CashierListLoadingState());

        cashierPagination.sendRequestForNextPage();

        Either<Failure, CashierListInfo> result = await _cashierRepository.getAllCashiers(
          currentPage: cashierPagination.currentPage,
        );

        result.fold((left) => debugPrint("cashiers error ${left.errorMessage}"), (right) {
          cashierPagination.gotNextPageData(right.cashiers, right.totalPageCount);

          emit(CashierListSuccessState(right.currentPageNumber, cashierPagination.hasMore));
        });
      }
    });

    on<GetAllCashiersSalesEvent>((event, emit) async {
      if (!event.getMore) {
        salesPagination.dispose();
      } else if (salesPagination.onFetching) {
        return;
      }

      if (salesPagination.hasMore) {
        _fromDate = event.fromDate;
        _toDate = event.toDate;

        // if (isSecondDateBigger(fromDate, toDate)) {
          if (salesPagination.currentPage == 1) emit(const SalesCashiersListLoadingState());

          salesPagination.sendRequestForNextPage();

          Either<Failure, CashierListInfo> result = await _cashierRepository.getAllFilteredCashiers(
            currentPage: salesPagination.currentPage,
            orderType: selectedSortType.sortType,
            orderField: selectedSortType.sortField,
            fromDate: fromDate,
            toDate: toDate,
          );

          result.fold((left) => debugPrint("sales error ${left.errorMessage}"), (right) {
            salesPagination.gotNextPageData(right.cashiers, right.totalPageCount);
            emit(SalesCashiersListSuccessState(right.currentPageNumber, salesPagination.hasMore));
          });
        // }
        // else {
        //   emit(WrongDateFilterRangeEnteredState(fromDate, toDate));
        // }
      }
    });

    on<ChangeSalesCashierOrder>((event, emit) {
      selectedSortType = event.salesSortType;
      add(GetAllCashiersSalesEvent(selectedCashierSortType: event.salesSortType));
    });

    on<CashierTopTabBarSelectedEvent>((event, emit) {
      selectedTabPos = event.selectedPosition;
      emit(CashierTopTabBarSelectedState(event.selectedPosition));
    });

    on<GetCashierRolesRequestEvent>((event, emit) async {
      Either<Failure, List<CashierRole>> result = await _cashierRepository.getCashierRoles();

      result.fold((left) => debugPrint("adding cashier failed ${left.errorMessage}"), (right) {
        cashierRoles = right;

        if (!(getIt<MainScreenBloc>().branchGeneralInfo?.isRestaurants ?? false)) {
          cashierRoles.removeWhere(
              (element) => element.roleName.toLowerCase() == 'kitchen' || element.roleName.toLowerCase() == 'waiter');
        }
        emit(const CashierRolesFetchSuccessState());
      });
    });

    on<AddCashierRequestEvent>((event, emit) async {
      emit(const EditCashierStates(isLoading: true));
      Either<Failure, bool> result =
          await _cashierRepository.addCashier(event.cashierName, event.cashierPassword, event.cashierRoleId);

      result.fold((left) => emit(EditCashierStates(errorMessage: left.errorMessage)), (right) {
        emit(const EditCashierStates(successMsg: "Cashier added successfully"));

        add(const GetAllCashiersEvent.refresh());
      });
    });

    on<EditCashierRequestEvent>((event, emit) async {
      emit(const EditCashierStates(isLoading: true));

      Either<Failure, bool> result =
          await _cashierRepository.editCashier(event.cashierId, event.cashierName, event.cashierRoleId, event.isActive);

      result.fold((left) => emit(EditCashierStates(errorMessage: left.errorMessage)), (right) {
        cashierPagination.listItems.firstWhere((element) => element.id == event.cashierId).update(
              cashierName: event.cashierName,
              cashierRoleId: event.cashierRoleId,
              cashierRoleName: event.cashierRoleName,
              isActive: event.isActive,
            );
        emit(const EditCashierStates(successMsg: "Cashier edited successfully"));
      });
    });
  }
}
