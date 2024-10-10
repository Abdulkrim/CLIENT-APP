part of 'credit_history_cubit.dart';

sealed class CreditHistoryState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;

  const CreditHistoryState({this.isLoading = false, this.isSuccess = false, this.errorMessage});

  @override
  List<Object?> get props => [isLoading, isSuccess, errorMessage];
}

final class CreditHistoryInitial extends CreditHistoryState {
  @override
  List<Object> get props => [];
}
final class GetCustomerCreditHistories extends CreditHistoryState {
  const GetCustomerCreditHistories({super.isLoading, super.isSuccess, super.errorMessage});


}
