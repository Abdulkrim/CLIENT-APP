part of 'loyalty_point_history_cubit.dart';

sealed class LoyaltyPointHistoryState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;

  const LoyaltyPointHistoryState({this.isLoading = false, this.errorMessage, this.isSuccess = false});

  @override
  List<Object?> get props => [isLoading, errorMessage, isSuccess];
}

final class LoyaltyPointHistoryInitial extends LoyaltyPointHistoryState {}

final class GetLoyaltyPointHistoryState extends LoyaltyPointHistoryState {
  const GetLoyaltyPointHistoryState({super.isLoading, super.errorMessage, super.isSuccess});
}
