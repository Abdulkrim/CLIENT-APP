part of 'loyalty_settings_cubit.dart';

sealed class LoyaltySettingsState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  const LoyaltySettingsState({this.isLoading = false, this.isSuccess = false, this.errorMessage});

  @override
  List<Object?> get props => [isLoading, isSuccess, errorMessage];
}

final class LoyaltySettingsInitial extends LoyaltySettingsState {}

final class GetLoyaltySettingsState extends LoyaltySettingsState {
  const GetLoyaltySettingsState({super.isLoading, super.errorMessage, super.isSuccess});
}

final class ManageLoyaltySettingsState extends LoyaltySettingsState {
  const ManageLoyaltySettingsState({super.isLoading, super.errorMessage, super.isSuccess});
}
