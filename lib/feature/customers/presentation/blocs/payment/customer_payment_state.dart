part of 'customer_payment_cubit.dart';

sealed class CustomerPaymentState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;

  const CustomerPaymentState({this.isLoading = false, this.isSuccess = false, this.errorMessage});

  @override
  List<Object?> get props => [isLoading, isSuccess, errorMessage];
}

final class CustomerPaymentInitial extends CustomerPaymentState {}

final class CreateCustomerPaymentState extends CustomerPaymentState {
  const CreateCustomerPaymentState({super.isLoading, super.isSuccess, super.errorMessage});
}

final class GetPaymentTypeStates extends CustomerPaymentState {
  const GetPaymentTypeStates({super.isLoading, super.isSuccess, super.errorMessage});
}
