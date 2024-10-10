part of 'cashier_reports_cubit.dart';

sealed class CashierReportsState extends Equatable {
  const CashierReportsState();

  @override
  List<Object> get props => [];
}

final class CashierReportsInitial extends CashierReportsState {}

final class GetCashiersLoadingState extends CashierReportsState {
  const GetCashiersLoadingState();
}

final class GetCashiersSuccessState extends CashierReportsState {
  final int page;
  final bool hasMore;
  const GetCashiersSuccessState(this.page, this.hasMore);

  @override
  List<Object> get props => [page, hasMore];
}

final class GetCashiersFailedState extends CashierReportsState {
  const GetCashiersFailedState();
}

final class GetDownloadLinkLoadingState extends CashierReportsState {
  const GetDownloadLinkLoadingState();
}

final class GetDownloadLinkState extends CashierReportsState {
  final String? link;
  final String? errorMsg;
  const GetDownloadLinkState({
    this.link,
    this.errorMsg,
  });
}
