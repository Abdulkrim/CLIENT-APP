import 'package:either_dart/either.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/core/utils/failure.dart';
import 'package:merchant_dashboard/feature/auth/data/data_sources/login_local_datasource.dart';
import 'package:merchant_dashboard/feature/dashboard/data/data_source/dashboard_remote_datasource.dart';
import 'package:merchant_dashboard/feature/dashboard/data/models/entities/top_sale_item.dart';
import 'package:merchant_dashboard/feature/dashboard/data/models/params/dashboard_data_parameter.dart';

import '../../../../core/utils/exceptions.dart';
import '../../../orders/data/models/response/top_last/top_last_orders_response.dart';
import '../models/entities/cashier_report.dart';
import '../models/entities/orders_statistics.dart';
import '../models/entities/sales_per_timeline.dart';
import '../models/entities/sales_statistics.dart';
import '../models/entities/worker_report.dart';
import '../models/responses/orders_statistics/orders_statistics_response.dart';
import '../models/responses/reports/report_response.dart';
import '../models/responses/sales/sales_per_timeline_response.dart';
import '../models/responses/sales/sales_statistics_response.dart';
import '../models/responses/top_items/top_sales_data_response.dart';
import '../models/responses/top_sub_categories/top_sub_categories_item_response.dart';

abstract class IDashboardRepository {
  Future<Either<Failure, List<SalesPerTimeline>>> getSalesPerToday();

  Future<Either<Failure, List<SalesPerTimeline>>> getSalesPerWeek();

  Future<Either<Failure, List<SalesPerTimeline>>> getSalesPerMonth();

  Future<Either<Failure, List<SalesPerTimeline>>> getSalesPerDate(String startDate, String endDate);

  Future<Either<Failure, SalesStatistics>> getSalesStatisticsPerToday();

  Future<Either<Failure, SalesStatistics>> getSalesStatisticsPerWeek();

  Future<Either<Failure, SalesStatistics>> getSalesStatisticsPerMonth();

  Future<Either<Failure, SalesStatistics>> getSalesStatisticsPerDate(String startDate, String endDate);

  Future<Either<Failure, OrdersStatistics>> getOrderStatisticsPerToday();

  Future<Either<Failure, OrdersStatistics>> getOrderStatisticsPerWeek();

  Future<Either<Failure, OrdersStatistics>> getOrderStatisticsPerMonth();

  Future<Either<Failure, OrdersStatistics>> getOrderStatisticsPerDate(String startDate, String endDate);

  Future<Either<Failure, List<TopSaleItem>>> getTopSalesPerToday({required bool isBasedOnQuantity});

  Future<Either<Failure, List<TopSaleItem>>> getTopOrderSalesPerToday({required bool isBasedOnQuantity});

  Future<Either<Failure, List<TopSaleItem>>> getTopSalesPerWeek({required bool isBasedOnQuantity});

  Future<Either<Failure, List<TopSaleItem>>> getTopOrderSalesPerWeek({required bool isBasedOnQuantity});

  Future<Either<Failure, List<TopSaleItem>>> getTopSalesPerMonth({required bool isBasedOnQuantity});

  Future<Either<Failure, List<TopSaleItem>>> getTopOrderSalesPerMonth({required bool isBasedOnQuantity});

  Future<Either<Failure, List<TopSaleItem>>> getTopSalesPerDate(
      {required String startDate, required String endDate, required bool isBasedOnQuantity});

  Future<Either<Failure, List<TopSaleItem>>> getTopOrderSalesPerDateRange(
      {required String startDate, required String endDate, required bool isBasedOnQuantity});

  Future<Either<Failure, List<CashierReport>>> getReportsPerToday();

  Future<Either<Failure, List<CashierReport>>> getReportsPerWeek();

  Future<Either<Failure, List<CashierReport>>> getReportsPerMonth();

  Future<Either<Failure, List<CashierReport>>> getReportsPerDate(String startDate, String endDate);

  Future<Either<Failure, List<TopSaleItem>>> getTopSubCategoriesPerToday({required bool isBasedOnQuantity});

  Future<Either<Failure, List<TopSaleItem>>> getTopOrderSubCategoriesPerToday({required bool isBasedOnQuantity});

  Future<Either<Failure, List<TopSaleItem>>> getTopSubCategoriesPerWeek({required bool isBasedOnQuantity});

  Future<Either<Failure, List<TopSaleItem>>> getTopOrderSubCategoriesPerWeek({required bool isBasedOnQuantity});

  Future<Either<Failure, List<TopSaleItem>>> getTopSubCategoriesPerMonth({required bool isBasedOnQuantity});

  Future<Either<Failure, List<TopSaleItem>>> getTopOrderSubCategoriesPerMonth({required bool isBasedOnQuantity});

  Future<Either<Failure, List<TopSaleItem>>> getTopSubCategoriesPerDate(
      {required String startDate, required String endDate, required bool isBasedOnQuantity});

  Future<Either<Failure, List<TopSaleItem>>> getTopOrderSubCategoriesPerDate(
      {required String startDate, required String endDate, required bool isBasedOnQuantity});

  Future<Either<Failure, List<WorkerReport>>> getWorkerSalesPerToday([DashboardDataParameter? dashboardParameter]);

  Future<Either<Failure, List<WorkerReport>>> getWorkerSalesPerWeek([DashboardDataParameter? dashboardParameter]);

  Future<Either<Failure, List<WorkerReport>>> getWorkerSalesPerMonth([DashboardDataParameter? dashboardParameter]);

  Future<Either<Failure, List<WorkerReport>>> getWorkerSalesPerDateRange(String startDate, String endDate);

  Future<Either<Failure, List<TopLastOrdersResponse>>> getTransactionOrdersPerToday();
  Future<Either<Failure, List<TopLastOrdersResponse>>> getTransactionOrdersPerMonth();
  Future<Either<Failure, List<TopLastOrdersResponse>>> getTransactionOrdersPerWeek();
  Future<Either<Failure, List<TopLastOrdersResponse>>> getTransactionOrdersPerDate(String? fromDate, String? toDate);
}

@LazySingleton(as: IDashboardRepository)
class DashboardRepository extends IDashboardRepository {
  final IDashboardRemoteDataSource _dashboardRemoteDataSource;

  DashboardRepository(this._dashboardRemoteDataSource);

  @override
  Future<Either<Failure, List<TopLastOrdersResponse>>> getTransactionOrdersPerToday() async {
    try {
      final List<TopLastOrdersResponse> response = await _dashboardRemoteDataSource.getTransactionOrdersPerToday();

      return Right(response);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, List<TopLastOrdersResponse>>> getTransactionOrdersPerMonth() async {
    try {
      final List<TopLastOrdersResponse> response = await _dashboardRemoteDataSource.getTransactionOrdersPerMonth();

      return Right(response);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, List<TopLastOrdersResponse>>> getTransactionOrdersPerWeek() async {
    try {
      final List<TopLastOrdersResponse> response = await _dashboardRemoteDataSource.getTransactionOrdersPerWeek();

      return Right(response);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, List<TopLastOrdersResponse>>> getTransactionOrdersPerDate(String? fromDate, String? toDate) async {
    try {
      final List<TopLastOrdersResponse> response = await _dashboardRemoteDataSource
          .getTransactionOrdersPerDate(DashboardDataParameter(startDate: '$fromDate', endDate: '$toDate'));

      return Right(response);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, List<SalesPerTimeline>>> getSalesPerDate(String startDate, String endDate) async {
    try {
      final SalesPerTimelineResponse? salesResponse =
          await _dashboardRemoteDataSource.getSalesPerDate(DashboardDataParameter(startDate: startDate, endDate: endDate));
      final List<SalesPerTimeline> salesEntity = salesResponse?.toEntity() ?? [];

      final SalesPerTimelineResponse? ordersResponse =
          await _dashboardRemoteDataSource.getOrdersPerDate(DashboardDataParameter(startDate: startDate, endDate: endDate));
      final List<SalesPerTimeline> ordersEntity = ordersResponse?.toEntity() ?? [];

      return Right(_getMergedList(salesEntity, ordersEntity));
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  List<SalesPerTimeline> _getMergedList(List<SalesPerTimeline> salesEntity, List<SalesPerTimeline> ordersEntity) {
    List<SalesPerTimeline> entityList = [];

    switch ((salesEntity, ordersEntity)) {
      case (List<SalesPerTimeline> salesEntity, List<SalesPerTimeline> ordersEntity)
          when salesEntity.length > ordersEntity.length:
        {
          entityList = salesEntity;
          entityList.firstOrNull?.firstPriceType = 'Sales';
          entityList.firstOrNull?.secondPriceType = 'Orders';

          for (var ent in entityList) {
            var matchingOrder = ordersEntity.firstWhereOrNull((order) => order.horizontalAxisValue == ent.horizontalAxisValue);
            if (matchingOrder != null) {
              ent.secondSumPrice = matchingOrder.sumPrice;
              ordersEntity.remove(matchingOrder);
            }
          }

          for (var order in ordersEntity) {
            order.secondSumPrice = order.sumPrice;
            order.sumPrice = 0;
            entityList.add(order);
          }
        }
      case (List<SalesPerTimeline> salesEntity, List<SalesPerTimeline> ordersEntity)
          when salesEntity.length < ordersEntity.length:
        {
          entityList = ordersEntity;
          entityList.firstOrNull?.firstPriceType = 'Orders';
          entityList.firstOrNull?.secondPriceType = 'Sales';

          for (var ent in entityList) {
            var matchingSale = salesEntity.firstWhereOrNull((order) => order.horizontalAxisValue == ent.horizontalAxisValue);
            if (matchingSale != null) {
              ent.secondSumPrice = matchingSale.sumPrice;
              salesEntity.remove(matchingSale);
            }
          }

          for (var sale in salesEntity) {
            sale.secondSumPrice = sale.sumPrice;
            sale.sumPrice = 0;
            entityList.add(sale);
          }
        }
      case (List<SalesPerTimeline> salesEntity, List<SalesPerTimeline> orderEntity) when salesEntity.length == orderEntity.length:
        {
          entityList = ordersEntity;
          entityList.firstOrNull?.firstPriceType = 'Orders';
          entityList.firstOrNull?.secondPriceType = 'Sales';

          for (var sale in salesEntity) {
            bool isAdded = false;

            for (var ent in entityList) {
              if (sale.horizontalAxisValue == ent.horizontalAxisValue) {
                isAdded = true;
                ent.secondSumPrice = sale.sumPrice;
              }
            }
            if (!isAdded) {
              sale.secondSumPrice = sale.sumPrice;
              sale.sumPrice = 0;
              entityList.add(sale);
            }
          }
        }
    }

    return entityList;
  }

  @override
  Future<Either<Failure, List<SalesPerTimeline>>> getSalesPerToday() async {
    try {
      final SalesPerTimelineResponse? salesResponse = await _dashboardRemoteDataSource.getSalesPerToday();
      final salesEntity = salesResponse?.toEntity() ?? [];
      final SalesPerTimelineResponse? orderResponse = await _dashboardRemoteDataSource.getOrdersPerToday();
      final ordersEntity = orderResponse?.toEntity() ?? [];

      return Right(_getMergedList(salesEntity, ordersEntity));
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, List<SalesPerTimeline>>> getSalesPerMonth() async {
    try {
      final SalesPerTimelineResponse? salesResponse = await _dashboardRemoteDataSource.getSalesPerMonth();
      final salesEntity = salesResponse?.toEntity() ?? [];
      final SalesPerTimelineResponse? orderResponse = await _dashboardRemoteDataSource.getOrdersPerMonth();
      final ordersEntity = orderResponse?.toEntity() ?? [];

      return Right(_getMergedList(salesEntity, ordersEntity));
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, List<SalesPerTimeline>>> getSalesPerWeek() async {
    try {
      final SalesPerTimelineResponse? salesResponse = await _dashboardRemoteDataSource.getSalesPerWeek();
      final salesEntity = salesResponse?.toEntity() ?? [];
      final SalesPerTimelineResponse? orderResponse = await _dashboardRemoteDataSource.getOrdersPerWeek();
      final ordersEntity = orderResponse?.toEntity() ?? [];

      return Right(_getMergedList(salesEntity, ordersEntity));
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, SalesStatistics>> getSalesStatisticsPerDate(String startDate, String endDate) async {
    try {
      final SalesStatisticsResponse response = await _dashboardRemoteDataSource
          .getSalesStatisticsPerDate(DashboardDataParameter(startDate: startDate, endDate: endDate));

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, SalesStatistics>> getSalesStatisticsPerMonth() async {
    try {
      final SalesStatisticsResponse response = await _dashboardRemoteDataSource.getSalesStatisticsPerMonth();

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, SalesStatistics>> getSalesStatisticsPerToday() async {
    try {
      final SalesStatisticsResponse response = await _dashboardRemoteDataSource.getSalesStatisticsPerToday();

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, SalesStatistics>> getSalesStatisticsPerWeek() async {
    try {
      final SalesStatisticsResponse response = await _dashboardRemoteDataSource.getSalesStatisticsPerWeek();

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, List<TopSaleItem>>> getTopSalesPerDate(
      {required String startDate, required String endDate, required bool isBasedOnQuantity}) async {
    try {
      final TopSalesResponse response = await _dashboardRemoteDataSource.getTopSalesPerDate(
          DashboardDataParameter(startDate: startDate, endDate: endDate, isBasedOnQuantity: isBasedOnQuantity));

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, List<TopSaleItem>>> getTopOrderSalesPerDateRange(
      {required String startDate, required String endDate, required bool isBasedOnQuantity}) async {
    try {
      final TopSalesResponse response = await _dashboardRemoteDataSource.getTopOrderSalesPerDateRange(
          DashboardDataParameter(startDate: startDate, endDate: endDate, isBasedOnQuantity: isBasedOnQuantity));

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, List<TopSaleItem>>> getTopSalesPerMonth({required bool isBasedOnQuantity}) async {
    try {
      final TopSalesResponse response =
          await _dashboardRemoteDataSource.getTopSalesPerMonth(DashboardDataParameter(isBasedOnQuantity: isBasedOnQuantity));

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, List<TopSaleItem>>> getTopOrderSalesPerMonth({required bool isBasedOnQuantity}) async {
    try {
      final TopSalesResponse response =
          await _dashboardRemoteDataSource.getTopOrderSalesPerMonth(DashboardDataParameter(isBasedOnQuantity: isBasedOnQuantity));

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, List<TopSaleItem>>> getTopSalesPerToday({required bool isBasedOnQuantity}) async {
    try {
      final TopSalesResponse response =
          await _dashboardRemoteDataSource.getTopSalesPerToday(DashboardDataParameter(isBasedOnQuantity: isBasedOnQuantity));

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, List<TopSaleItem>>> getTopOrderSalesPerToday({required bool isBasedOnQuantity}) async {
    try {
      final TopSalesResponse response =
          await _dashboardRemoteDataSource.getTopOrderSalesPerToday(DashboardDataParameter(isBasedOnQuantity: isBasedOnQuantity));

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, List<TopSaleItem>>> getTopSalesPerWeek({required bool isBasedOnQuantity}) async {
    try {
      final TopSalesResponse response =
          await _dashboardRemoteDataSource.getTopSalesPerWeek(DashboardDataParameter(isBasedOnQuantity: isBasedOnQuantity));

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, List<TopSaleItem>>> getTopOrderSalesPerWeek({required bool isBasedOnQuantity}) async {
    try {
      final TopSalesResponse response =
          await _dashboardRemoteDataSource.getTopOrderSalesPerWeek(DashboardDataParameter(isBasedOnQuantity: isBasedOnQuantity));

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, List<CashierReport>>> getReportsPerDate(String startDate, String endDate) async {
    try {
      final ReportsResponse response =
          await _dashboardRemoteDataSource.getReportsPerDate(DashboardDataParameter(startDate: startDate, endDate: endDate));

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, List<CashierReport>>> getReportsPerMonth() async {
    try {
      final ReportsResponse response = await _dashboardRemoteDataSource.getReportsPerMonth();

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, List<CashierReport>>> getReportsPerToday() async {
    try {
      final ReportsResponse response = await _dashboardRemoteDataSource.getReportsPerToday();

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, List<CashierReport>>> getReportsPerWeek() async {
    try {
      final ReportsResponse response = await _dashboardRemoteDataSource.getReportsPerWeek();

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, List<TopSaleItem>>> getTopSubCategoriesPerDate(
      {required String startDate, required String endDate, required bool isBasedOnQuantity}) async {
    try {
      final TopSubCategoriesResponse response = await _dashboardRemoteDataSource.getTopSubCategoriesPerDate(
          DashboardDataParameter(startDate: startDate, endDate: endDate, isBasedOnQuantity: isBasedOnQuantity));

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, List<TopSaleItem>>> getTopOrderSubCategoriesPerDate(
      {required String startDate, required String endDate, required bool isBasedOnQuantity}) async {
    try {
      final TopSubCategoriesResponse response = await _dashboardRemoteDataSource.getTopOrderSubCategoriesPerDate(
          DashboardDataParameter(startDate: startDate, endDate: endDate, isBasedOnQuantity: isBasedOnQuantity));

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, List<TopSaleItem>>> getTopSubCategoriesPerMonth({required bool isBasedOnQuantity}) async {
    try {
      final TopSubCategoriesResponse response = await _dashboardRemoteDataSource
          .getTopSubCategoriesPerMonth(DashboardDataParameter(isBasedOnQuantity: isBasedOnQuantity));

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, List<TopSaleItem>>> getTopOrderSubCategoriesPerMonth({required bool isBasedOnQuantity}) async {
    try {
      final TopSubCategoriesResponse response = await _dashboardRemoteDataSource
          .getTopOrderSubCategoriesPerMonth(DashboardDataParameter(isBasedOnQuantity: isBasedOnQuantity));

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, List<TopSaleItem>>> getTopSubCategoriesPerToday({required bool isBasedOnQuantity}) async {
    try {
      final TopSubCategoriesResponse response = await _dashboardRemoteDataSource
          .getTopSubCategoriesPerToday(DashboardDataParameter(isBasedOnQuantity: isBasedOnQuantity));

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, List<TopSaleItem>>> getTopOrderSubCategoriesPerToday({required bool isBasedOnQuantity}) async {
    try {
      final TopSubCategoriesResponse response = await _dashboardRemoteDataSource
          .getTopOrderSubCategoriesPerToday(DashboardDataParameter(isBasedOnQuantity: isBasedOnQuantity));

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, List<TopSaleItem>>> getTopSubCategoriesPerWeek({required bool isBasedOnQuantity}) async {
    try {
      final TopSubCategoriesResponse response = await _dashboardRemoteDataSource
          .getTopSubCategoriesPerWeek(DashboardDataParameter(isBasedOnQuantity: isBasedOnQuantity));

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, List<TopSaleItem>>> getTopOrderSubCategoriesPerWeek({required bool isBasedOnQuantity}) async {
    try {
      final TopSubCategoriesResponse response = await _dashboardRemoteDataSource
          .getTopOrderSubCategoriesPerWeek(DashboardDataParameter(isBasedOnQuantity: isBasedOnQuantity));

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, OrdersStatistics>> getOrderStatisticsPerDate(String startDate, String endDate) async {
    try {
      final OrdersStatisticsResponse response = await _dashboardRemoteDataSource
          .getOrdersStatisticsPerDate(DashboardDataParameter(startDate: startDate, endDate: endDate));

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, OrdersStatistics>> getOrderStatisticsPerMonth() async {
    try {
      final OrdersStatisticsResponse response = await _dashboardRemoteDataSource.getOrdersStatisticsPerMonth();

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, OrdersStatistics>> getOrderStatisticsPerToday() async {
    try {
      final OrdersStatisticsResponse response = await _dashboardRemoteDataSource.getOrdersStatisticsPerToday();

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, OrdersStatistics>> getOrderStatisticsPerWeek() async {
    try {
      final OrdersStatisticsResponse response = await _dashboardRemoteDataSource.getOrdersStatisticsPerWeek();

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, List<WorkerReport>>> getWorkerSalesPerDateRange(String startDate, String endDate) async {
    try {
      final response = await _dashboardRemoteDataSource
          .getWorkerSalesPerDateRange(DashboardDataParameter(startDate: startDate, endDate: endDate));

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, List<WorkerReport>>> getWorkerSalesPerMonth([DashboardDataParameter? dashboardParameter]) async {
    try {
      final response = await _dashboardRemoteDataSource.getWorkerSalesPerMonth();

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, List<WorkerReport>>> getWorkerSalesPerToday([DashboardDataParameter? dashboardParameter]) async {
    try {
      final response = await _dashboardRemoteDataSource.getWorkerSalesPerToday();

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, List<WorkerReport>>> getWorkerSalesPerWeek([DashboardDataParameter? dashboardParameter]) async {
    try {
      final response = await _dashboardRemoteDataSource.getWorkerSalesPerWeek();

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }
}
