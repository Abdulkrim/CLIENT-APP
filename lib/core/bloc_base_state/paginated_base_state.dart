import 'package:merchant_dashboard/core/utils/failure.dart';

enum PaginatedListStatus {
  initial,
  inProgress,
  success,
  failure,
  paginateInProgress,
  paginateFailure,
}

class BasePaginatedListState<T> {
  final PaginatedListStatus status;
  final List<T> items;
  final Failure? failure;
  final bool hasReachedMax;
  final int? totalRecords;

  BasePaginatedListState<T> initial() =>
      const BasePaginatedListState(status: PaginatedListStatus.initial);

  const BasePaginatedListState({
    this.status = PaginatedListStatus.initial,
    this.items = const [],
    this.failure,
    this.hasReachedMax = false,
    this.totalRecords,
  });

  BasePaginatedListState<T> setInProgressState() => BasePaginatedListState<T>(
    status: PaginatedListStatus.inProgress,
  );
  BasePaginatedListState<T> setSuccessState(List<T> items) =>
      BasePaginatedListState<T>(
          status: PaginatedListStatus.success, items: items);

  BasePaginatedListState<T> setFailureState(Failure failure) =>
      BasePaginatedListState<T>(
        status: PaginatedListStatus.failure,
        failure: failure,
      );
  BasePaginatedListState<T> setPaginateInProgressState() =>
      BasePaginatedListState<T>(
        status: PaginatedListStatus.paginateInProgress,
      );
  BasePaginatedListState<T> setPaginateFailureState(Failure failure) =>
      BasePaginatedListState<T>(
        status: PaginatedListStatus.paginateFailure,
        failure: failure,
      );

  bool get isInitial => status == PaginatedListStatus.initial;

  bool get isInProgress => status == PaginatedListStatus.inProgress;

  bool get isPaginateInProgress =>
      status == PaginatedListStatus.paginateInProgress;

  bool get isFailure => status == PaginatedListStatus.failure;

  bool get isPaginateFailure => status == PaginatedListStatus.paginateFailure;

  bool get isSuccess => status == PaginatedListStatus.success;

  BasePaginatedListState<T> copyWith({
    PaginatedListStatus? status,
    List<T>? items,
    Failure? failure,
    bool? hasReachedMax,
    int? totalRecords,
  }) {
    return BasePaginatedListState<T>(
      status: status ?? this.status,
      items: items ?? this.items,
      failure: failure ?? this.failure,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      totalRecords: totalRecords ?? this.totalRecords,
    );
  }
}
