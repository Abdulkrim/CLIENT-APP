part of 'payment_status_cubit.dart';

sealed class PaymentStatusState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class PaymentStatusInitial extends PaymentStatusState {}

final class PaymentStatusResultState extends PaymentStatusState {
  final bool isLoading;
  final String? errorMessage;
  final bool isSuccess;

  PaymentStatusResultState({this.isLoading = false, this.errorMessage, this.isSuccess = false});

  @override
  List<Object?> get props => [isLoading, errorMessage, isSuccess];
}
