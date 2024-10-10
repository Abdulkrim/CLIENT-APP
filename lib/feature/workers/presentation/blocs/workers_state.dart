part of 'workers_cubit.dart';

sealed class WorkersState extends Equatable {
  final bool isLoading;
  final String? successMessage;
  final String? errorMessage;

  const WorkersState({this.isLoading = false, this.successMessage, this.errorMessage});

  @override
  List<Object?> get props => [isLoading, successMessage, errorMessage];
}

final class WorkersInitial extends WorkersState {}

final class WorkersListLoading extends WorkersState {}

final class WorkerListStates extends WorkersState {
  final bool hasMore;
  const WorkerListStates({super.isLoading, this.hasMore = false});

  @override
  List<Object> get props => [hasMore];
}

final class GetSalesWorkerLoadingState extends WorkersState {}

final class SalesWorkersListState extends WorkersState {
  final bool hasMore;
  const SalesWorkersListState({super.isLoading, this.hasMore = false});

  @override
  List<Object> get props => [hasMore];
}

final class WorkerUpdateStates extends WorkersState {
  const WorkerUpdateStates({super.isLoading, super.successMessage, super.errorMessage});
}
