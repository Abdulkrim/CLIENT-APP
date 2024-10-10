part of 'expense_cubit.dart';

sealed class ExpenseState extends Equatable {
  final bool isLoading;
  final String successMessage;
  final String errorMessage;

  const ExpenseState({this.isLoading = false, this.errorMessage = '', this.successMessage = ''});

  @override
  List<Object> get props => [isLoading, errorMessage, successMessage];
}

final class ExpenseInitial extends ExpenseState {}

final class GetExpensesState extends ExpenseState {
  final bool isMoreLoading;
  final bool hasMore;
  const GetExpensesState(
      {super.isLoading,
      super.errorMessage,
      super.successMessage,
      this.hasMore = false,
      this.isMoreLoading = false});

  @override
  List<Object> get props => [hasMore, isMoreLoading , isLoading ,errorMessage,successMessage ];
}

final class GetExpenseTypesState extends ExpenseState {
  const GetExpenseTypesState({super.isLoading, super.errorMessage, super.successMessage});
}

final class GetPaymentTypesState extends ExpenseState {
  const GetPaymentTypesState({super.isLoading, super.errorMessage, super.successMessage});
}

final class AddExpenseTypesState extends ExpenseState {
  const AddExpenseTypesState({super.isLoading, super.errorMessage, super.successMessage});
}

final class AddExpenseState extends ExpenseState {
  const AddExpenseState({super.isLoading, super.errorMessage, super.successMessage});
}
