part of 'dashboard_bloc.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

class DashboardInitial extends DashboardState {}

class GetSalesLoadingState extends DashboardState {
  const GetSalesLoadingState();
}

class GetSalesFailedState extends DashboardState {
  final String msg;

  const GetSalesFailedState(this.msg);

  @override
  List<Object> get props => [msg];
}

class GetSalesSuccessState extends DashboardState {
  final List<SalesPerTimeline> sales;
  final String timeText;

  const GetSalesSuccessState(this.sales, this.timeText);

  @override
  List<Object> get props => [sales, timeText];
}

class GetSalesStatisticsLoadingState extends DashboardState {
  const GetSalesStatisticsLoadingState();
}

class GetSalesStatisticsFailedState extends DashboardState {
  final String msg;

  const GetSalesStatisticsFailedState(this.msg);

  @override
  List<Object> get props => [msg];
}

class GetSalesStatisticsSuccessState extends DashboardState {
  final List<PaymentStatsItem> paymentStats;
  final String totalAmount;

  const GetSalesStatisticsSuccessState(this.paymentStats, this.totalAmount);

  @override
  List<Object> get props => [paymentStats, totalAmount];
}

class GetTopSalesLoadingState extends DashboardState {
  const GetTopSalesLoadingState();
}

class GetTopSalesFailedState extends DashboardState {
  final String msg;

  const GetTopSalesFailedState(this.msg);

  @override
  List<Object> get props => [msg];
}

class GetTopSalesSuccessState extends DashboardState {
  final List<TopSaleItem> products;

  const GetTopSalesSuccessState(this.products);

  @override
  List<Object> get props => [products];
}

class GetReportsLoadingState extends DashboardState {
  const GetReportsLoadingState();
}

class GetReportsFailedState extends DashboardState {
  final String msg;

  const GetReportsFailedState(this.msg);

  @override
  List<Object> get props => [msg];
}

class GetReportsSuccessState extends DashboardState {
  final List<CashierReport> cashiers;

  const GetReportsSuccessState(this.cashiers);

  @override
  List<Object> get props => [cashiers];
}

class GetTopSubCategoriesLoadingState extends DashboardState {
  const GetTopSubCategoriesLoadingState();
}

class GetTopSubCategoriesFailedState extends DashboardState {
  final String msg;

  const GetTopSubCategoriesFailedState(this.msg);

  @override
  List<Object> get props => [msg];
}

class GetTopSubCategoriesSuccessState extends DashboardState {
  final List<TopSaleItem> cashiers;

  const GetTopSubCategoriesSuccessState(this.cashiers);

  @override
  List<Object> get props => [cashiers];
}

class GetTransactionsLoadingState extends DashboardState {
  const GetTransactionsLoadingState();
}

class GetTransactionsFailedState extends DashboardState {
  final String msg;

  const GetTransactionsFailedState(this.msg);

  @override
  List<Object> get props => [msg];
}

class GetTransactionsSuccessState extends DashboardState {
  final List<Transaction> cashiers;

  const GetTransactionsSuccessState(this.cashiers);

  @override
  List<Object> get props => [cashiers];
}

class GetOrdersStatisticsLoadingState extends DashboardState {
  const GetOrdersStatisticsLoadingState();
}

class GetOrdersStatisticsFailedState extends DashboardState {
  final String msg;

  const GetOrdersStatisticsFailedState(this.msg);

  @override
  List<Object> get props => [msg];
}

class GetOrdersStatisticsSuccessState extends DashboardState {
  final String sumPrice;

  const GetOrdersStatisticsSuccessState(this.sumPrice);

  @override
  List<Object> get props => [sumPrice];
}

class GetWorkersStates extends DashboardState {
  final bool isLoading;
  final String errorMessage;
  final String successDate;

  const GetWorkersStates({this.isLoading = false, this.errorMessage = '', this.successDate = ''});
}
