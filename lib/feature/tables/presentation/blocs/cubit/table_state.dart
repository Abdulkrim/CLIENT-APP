part of 'table_cubit.dart';

sealed class TableState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String successMessage;
  final String errorMessage;

  const TableState(
      {this.isLoading = false, this.errorMessage = '', this.successMessage = '', this.isSuccess = false});

  @override
  List<Object> get props => [isLoading, errorMessage, successMessage, isSuccess];
}

final class TableInitial extends TableState {}

class GetTableStates extends TableState {
  const GetTableStates({
    super.isLoading,
    super.errorMessage,
    super.isSuccess,
  });
}

class EditTableStates extends TableState {
  const EditTableStates({
    super.isLoading,
    super.errorMessage,
    super.successMessage,
  });
}
