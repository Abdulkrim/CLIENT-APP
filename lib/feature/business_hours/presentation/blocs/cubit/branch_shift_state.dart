part of 'branch_shift_cubit.dart';

sealed class BranchShiftState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMsg;

  const BranchShiftState({this.errorMsg, this.isLoading = false, this.isSuccess = false});

  @override
  List<Object?> get props => [isLoading, isSuccess, errorMsg];
}

final class BranchShiftInitial extends BranchShiftState {}

final class GetBranchShiftState extends BranchShiftState {
  const GetBranchShiftState({super.isLoading, super.isSuccess, super.errorMsg});
}

final class AddExceptionState extends BranchShiftState {
  const AddExceptionState({super.isLoading, super.isSuccess, super.errorMsg});
}

final class ManageBranchShiftState extends BranchShiftState {
  const ManageBranchShiftState({super.isLoading, super.isSuccess, super.errorMsg});
}

final class BranchShiftUpdated extends BranchShiftState {}