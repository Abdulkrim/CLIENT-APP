import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/core/utils/failure.dart';
import 'package:merchant_dashboard/feature/subscription/data/models/entity/shared_feature.dart';
import 'package:merchant_dashboard/feature/subscription/data/models/enums/subscription_periods.dart';
import 'package:merchant_dashboard/feature/subscription/data/repository/subscription_repository.dart';

import '../../../../../../injection.dart';
import '../../../../../../utils/mixins/mixins.dart';
import '../../../../../main_screen/presentation/blocs/main_screen_bloc.dart';
import '../../../../data/models/entity/branch_plan_details.dart';
import '../../../../data/models/entity/subscription_package_calculate.dart';
import '../../../../data/models/entity/subscription_package_details.dart';
import '../../../../data/models/entity/subscription_plan.dart';

part 'select_plan_state.dart';

@injectable
class SelectPlanCubit extends Cubit<SelectPlanState> with DownloadUtils {
  final ISubscriptionRepository _subscriptionRepository;

  SubscriptionPeriods selectedSubscriptionPeriod = SubscriptionPeriods.monthly;
  int selectedPeriodDuration = 1;
  List<int> selectedAddonItems = [];
  SubscriptionPackageCalculate? selectedPackageCalculation;

  SelectPlanCubit(this._subscriptionRepository) : super(SelectPlanInitial()) {
    getIt<MainScreenBloc>().stream.listen((state) {
      if (state is MerchantInfoSelectionChangedState && state.merchantInfo.hasData) {
        getCurrentBranchPlanDetails();
        getAllPlans();
        getSharedFeatures();
      }
    });
  }

  List<SubscriptionPlan> subscriptionPlans = [];

  List<SharedFeature> sharedFeatures = [];

  SubscriptionPlan? selectedPlan;

  BranchPlanDetails? planDetails;
  bool isExpired = false;

  void getCurrentBranchPlanDetails() async {
    emit(const GetBranchDetailsState(isLoading: true));

    final result = await _subscriptionRepository.getCurrentBranchPlanDetails();

    result.fold((left) {
      if (left is ServerError && left.code == '404') {
        isExpired = true;
      }
      emit(GetBranchDetailsState(errorMessage: left.errorMessage));
    }, (right) {
      isExpired = false;
      planDetails = right;
      emit(const GetBranchDetailsState(isSuccessed: true));
    });
  }

  void getAllPlans() async {
    emit(const GetAllPlansState(isLoading: true));
    final result = await _subscriptionRepository.getAllPlans();

    result.fold((left) => emit(GetAllPlansState(errorMessage: left.errorMessage)), (right) {
      subscriptionPlans = right;
      emit(const GetAllPlansState(isSuccessed: true));
    });
  }

  void getSharedFeatures() async {
    emit(const GetSharedFeaturesState(isLoading: true));
    final result = await _subscriptionRepository.getSharedFeatures();

    result.fold((left) => emit(GetSharedFeaturesState(errorMessage: left.errorMessage)), (right) {
      sharedFeatures = right;
      emit(const GetSharedFeaturesState(isSuccessed: true));
    });
  }

  void getSubscriptionPackageDetails(SubscriptionPlan plan) async {
    selectedPlan = plan;
    selectedAddonItems.clear();
    selectedPackageCalculation = null;
    emit(const GetSubscriptionPackgeDetailsState(isLoading: true));
    final result = await _subscriptionRepository.getSubscriptionPlanDetails(packageId: plan.id);

    result.fold((left) => emit(GetSubscriptionPackgeDetailsState(errorMessage: left.errorMessage)),
        (right) => emit(GetSubscriptionPackgeDetailsState(packageDetails: right)));
  }

  void getSelectedPlanCalculate() async {
    emit(const SelectedPlanCalulateState(isLoading: true));
    final result = await _subscriptionRepository.getSelectedPlanCalculate(
        packageId: selectedPlan!.id,
        addonItems: selectedAddonItems,
        duration: selectedPeriodDuration,
        interval: selectedSubscriptionPeriod.value);

    result.fold((left) {
      if (left is! CancelledError) emit(SelectedPlanCalulateState(errorMessage: left.errorMessage));
    }, (right) {
      selectedPackageCalculation = right;
      emit(SelectedPlanCalulateState(planPriceInfo: right));
    });
  }

  void subscribeToPackage({required int payTypeId}) async {
    emit(const SubscribeToPackageState(isLoading: true));
    final result = await _subscriptionRepository.subscribeToPackage(
        packageId: selectedPlan!.id,
        addonItems: selectedAddonItems,
        duration: selectedPeriodDuration,
        payType: payTypeId,
        interval: selectedSubscriptionPeriod.value);

    result.fold((left) => emit(SubscribeToPackageState(errorMessage: left.errorMessage)), (right) {
      openLink(url: right.payLink, openInNewTab: false);
    });
  }
}
