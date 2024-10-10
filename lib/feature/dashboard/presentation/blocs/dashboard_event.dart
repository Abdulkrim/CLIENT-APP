part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object?> get props => [];
}

class GetTodayDataEvent extends DashboardEvent {
  final bool? isBasedOnQuantity;
  const GetTodayDataEvent({this.isBasedOnQuantity});
}

class GetWeekDataEvent extends DashboardEvent {
  final bool? isBasedOnQuantity;
  const GetWeekDataEvent({this.isBasedOnQuantity});
}

class GetMonthDataEvent extends DashboardEvent {
  final bool? isBasedOnQuantity;
  const GetMonthDataEvent({this.isBasedOnQuantity});
}

class GetRangeDataEvent extends DashboardEvent {
  final String startDate;
  final String endDate;
  final bool? isBasedOnQuantity;

  const GetRangeDataEvent(this.startDate, this.endDate, [this.isBasedOnQuantity]);

  @override
  List<Object> get props => [startDate, endDate];
}

class ChangeTopSalesProductBaseEvent extends DashboardEvent {
  final bool isBasedOnQuantity;

  const ChangeTopSalesProductBaseEvent(this.isBasedOnQuantity);

  @override
  List<Object?> get props => [isBasedOnQuantity];
}

class ChangeTopOrderProductsBaseEvent extends DashboardEvent {
  final bool isBasedOnQuantity;

  const ChangeTopOrderProductsBaseEvent(this.isBasedOnQuantity);

  @override
  List<Object?> get props => [isBasedOnQuantity];
}

class GetSalesPerToday extends DashboardEvent {
  const GetSalesPerToday();
}

class GetSalesPerWeek extends DashboardEvent {
  const GetSalesPerWeek();
}

class GetSalesPerMonth extends DashboardEvent {
  const GetSalesPerMonth();
}

class GetSalesPerDateRange extends DashboardEvent {
  final String startDate;
  final String endDate;

  const GetSalesPerDateRange(this.startDate, this.endDate);

  @override
  List<Object> get props => [startDate, endDate];
}

class GetSalesStatisticsPerToday extends DashboardEvent {
  const GetSalesStatisticsPerToday();
}

class GetSalesStatisticsPerWeek extends DashboardEvent {
  const GetSalesStatisticsPerWeek();
}

class GetSalesStatisticsPerMonth extends DashboardEvent {
  const GetSalesStatisticsPerMonth();
}

class GetSalesStatisticsPerDateRange extends DashboardEvent {
  final String startDate;
  final String endDate;

  const GetSalesStatisticsPerDateRange(this.startDate, this.endDate);

  @override
  List<Object> get props => [startDate, endDate];
}

class GetTopSalesPerToday extends DashboardEvent {
  final bool isBasedOnQuantity;
  const GetTopSalesPerToday({required this.isBasedOnQuantity});
  @override
  List<Object> get props => [isBasedOnQuantity];
}

class GetTopOrderSalesPerToday extends DashboardEvent {
  final bool isBasedOnQuantity;
  const GetTopOrderSalesPerToday({required this.isBasedOnQuantity});
  @override
  List<Object> get props => [isBasedOnQuantity];
}

class GetTopSalesPerWeek extends DashboardEvent {
  final bool isBasedOnQuantity;
  const GetTopSalesPerWeek({required this.isBasedOnQuantity});
  @override
  List<Object> get props => [isBasedOnQuantity];
}

class GetTopOrderSalesPerWeek extends DashboardEvent {
  final bool isBasedOnQuantity;
  const GetTopOrderSalesPerWeek({required this.isBasedOnQuantity});
  @override
  List<Object> get props => [isBasedOnQuantity];
}

class GetTopOrderSubCategoriesPerMonth extends DashboardEvent {
  final bool isBasedOnQuantity;
  const GetTopOrderSubCategoriesPerMonth({required this.isBasedOnQuantity});
  @override
  List<Object> get props => [isBasedOnQuantity];
}

class GetTopOrderSubCategoriesPerWeek extends DashboardEvent {
  final bool isBasedOnQuantity;
  const GetTopOrderSubCategoriesPerWeek({required this.isBasedOnQuantity});
  @override
  List<Object> get props => [isBasedOnQuantity];
}

class GetTopOrderSubCategoriesPerToday extends DashboardEvent {
  final bool isBasedOnQuantity;
  const GetTopOrderSubCategoriesPerToday({required this.isBasedOnQuantity});
  @override
  List<Object> get props => [isBasedOnQuantity];
}

class GetTopOrderSalesPerMonth extends DashboardEvent {
  final bool isBasedOnQuantity;
  const GetTopOrderSalesPerMonth({required this.isBasedOnQuantity});
  @override
  List<Object> get props => [isBasedOnQuantity];
}

class GetTopSalesPerMonth extends DashboardEvent {
  final bool isBasedOnQuantity;
  const GetTopSalesPerMonth({required this.isBasedOnQuantity});
  @override
  List<Object> get props => [isBasedOnQuantity];
}

class GetTopSalesPerDateRange extends DashboardEvent {
  final String startDate;
  final String endDate;
  final bool isBasedOnQuantity;
  const GetTopSalesPerDateRange(this.startDate, this.endDate, this.isBasedOnQuantity);

  @override
  List<Object> get props => [startDate, endDate, isBasedOnQuantity];
}

class GetTopOrderSalesPerDateRange extends DashboardEvent {
  final String startDate;
  final String endDate;
  final bool isBasedOnQuantity;

  const GetTopOrderSalesPerDateRange(this.startDate, this.endDate, this.isBasedOnQuantity);

  @override
  List<Object> get props => [startDate, endDate, isBasedOnQuantity];
}

class GetTopOrderSubCategoriesPerDate extends DashboardEvent {
  final String startDate;
  final String endDate;
  final bool isBasedOnQuantity;

  const GetTopOrderSubCategoriesPerDate(this.startDate, this.endDate, this.isBasedOnQuantity);

  @override
  List<Object> get props => [startDate, endDate, isBasedOnQuantity];
}

class GetReportsPerToday extends DashboardEvent {
  const GetReportsPerToday();
}

class GetReportsPerWeek extends DashboardEvent {
  const GetReportsPerWeek();
}

class GetReportsPerMonth extends DashboardEvent {
  const GetReportsPerMonth();
}

class GetReportsPerDate extends DashboardEvent {
  final String startDate;
  final String endDate;

  const GetReportsPerDate(this.startDate, this.endDate);

  @override
  List<Object> get props => [startDate, endDate];
}

class GetTopSubCategoriesPerToday extends DashboardEvent {
  final bool isBasedOnQuantity;
  const GetTopSubCategoriesPerToday({required this.isBasedOnQuantity});
  @override
  List<Object> get props => [isBasedOnQuantity];
}

class GetTopSubCategoriesPerWeek extends DashboardEvent {
  final bool isBasedOnQuantity;
  const GetTopSubCategoriesPerWeek({required this.isBasedOnQuantity});
  @override
  List<Object> get props => [isBasedOnQuantity];
}

class GetTopSubCategoriesPerMonth extends DashboardEvent {
  final bool isBasedOnQuantity;
  const GetTopSubCategoriesPerMonth({required this.isBasedOnQuantity});
  @override
  List<Object> get props => [isBasedOnQuantity];
}

class GetTopSubCategoriesPerDate extends DashboardEvent {
  final String startDate;
  final String endDate;
  final bool isBasedOnQuantity;
  const GetTopSubCategoriesPerDate(this.startDate, this.endDate, this.isBasedOnQuantity);

  @override
  List<Object> get props => [startDate, endDate, isBasedOnQuantity];
}

class GetOrdersPerToday extends DashboardEvent {
  const GetOrdersPerToday();
}

class GetOrdersPerWeek extends DashboardEvent {
  const GetOrdersPerWeek();
}

class GetOrdersPerMonth extends DashboardEvent {
  const GetOrdersPerMonth();
}

class GetOrdersPerDate extends DashboardEvent {
  final String startDate;
  final String endDate;

  const GetOrdersPerDate(this.startDate, this.endDate);

  @override
  List<Object> get props => [startDate, endDate];
}

class GetTransactionsPerToday extends DashboardEvent {
  const GetTransactionsPerToday();
}

class GetTransactionsPerWeek extends DashboardEvent {
  const GetTransactionsPerWeek();
}

class GetTransactionsPerMonth extends DashboardEvent {
  const GetTransactionsPerMonth();
}

class GetTransactionsPerDate extends DashboardEvent {
  final String startDate;
  final String endDate;

  const GetTransactionsPerDate(this.startDate, this.endDate);

  @override
  List<Object> get props => [startDate, endDate];
}

class GetOrdersStatisticsPerToday extends DashboardEvent {
  const GetOrdersStatisticsPerToday();
}

class GetOrdersStatisticsPerWeek extends DashboardEvent {
  const GetOrdersStatisticsPerWeek();
}

class GetOrdersStatisticsPerMonth extends DashboardEvent {
  const GetOrdersStatisticsPerMonth();
}

class GetOrdersStatisticsPerDate extends DashboardEvent {
  final String startDate;
  final String endDate;

  const GetOrdersStatisticsPerDate(this.startDate, this.endDate);

  @override
  List<Object> get props => [startDate, endDate];
}

class GetWorkersPerToday extends DashboardEvent {
  const GetWorkersPerToday();
}

class GetWorkersPerWeek extends DashboardEvent {
  const GetWorkersPerWeek();
}

class GetWorkersPerMonth extends DashboardEvent {
  const GetWorkersPerMonth();
}

class GetWorkersPerDate extends DashboardEvent {
  final String startDate;
  final String endDate;

  const GetWorkersPerDate(this.startDate, this.endDate);

  @override
  List<Object> get props => [startDate, endDate];
}
