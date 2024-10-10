part of 'select_plan_cubit.dart';

sealed class SelectPlanState extends Equatable {
  final bool isLoading;
  final bool isSuccessed;
  final String successMessage;
  final String errorMessage;

  const SelectPlanState(
      {this.isLoading = false, this.errorMessage = '', this.successMessage = '', this.isSuccessed = false});

  @override
  List<Object> get props => [isLoading, errorMessage, successMessage, isSuccessed];
}

final class SelectPlanInitial extends SelectPlanState {}

final class GetBranchDetailsState extends SelectPlanState {
  const GetBranchDetailsState({super.isLoading, super.errorMessage, super.isSuccessed});
}

final class GetAllPlansState extends SelectPlanState {
  const GetAllPlansState({super.isLoading, super.errorMessage, super.isSuccessed});
}

final class SubscribeToPackageState extends SelectPlanState {
  const SubscribeToPackageState({super.isLoading, super.errorMessage, super.isSuccessed});
}

final class GetSharedFeaturesState extends SelectPlanState {
  const GetSharedFeaturesState({super.isLoading, super.errorMessage, super.isSuccessed});
}

final class GetSubscriptionPackgeDetailsState extends SelectPlanState {
  final List<SubscriptionPackageDetails>? packageDetails;
  const GetSubscriptionPackgeDetailsState({super.isLoading, super.errorMessage, this.packageDetails});
}

final class SelectedPlanCalulateState extends SelectPlanState {
  final SubscriptionPackageCalculate? planPriceInfo;
  const SelectedPlanCalulateState({super.isLoading, super.errorMessage, this.planPriceInfo});
}
