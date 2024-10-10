part of 'billing_history_cubit.dart';

sealed class BillingHistoryState extends Equatable {
  final bool isLoading;
  final bool isSuccessed;
  final String successMessage;
  final String errorMessage;

  const BillingHistoryState({this.isLoading = false, this.errorMessage = '', this.successMessage = '', this.isSuccessed = false});

  @override
  List<Object> get props => [isLoading, errorMessage, successMessage, isSuccessed];
}

final class BillingHistoryInitial extends BillingHistoryState {}

final class GetBillingHistoryState extends BillingHistoryState {
  final int currentPage;

  const GetBillingHistoryState({this.currentPage = 1, super.isLoading, super.errorMessage, super.isSuccessed});

  @override
  List<Object> get props => [currentPage];
}

final class RePaymentRequestState extends BillingHistoryState {
  const RePaymentRequestState({super.isLoading, super.isSuccessed, super.errorMessage});
}
