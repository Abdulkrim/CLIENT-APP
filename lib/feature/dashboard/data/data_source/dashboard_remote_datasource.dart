import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/feature/dashboard/data/models/params/dashboard_data_parameter.dart';
import 'package:merchant_dashboard/feature/dashboard/data/models/responses/reports/report_response.dart';
import 'package:merchant_dashboard/feature/dashboard/data/models/responses/sales/sales_per_timeline_response.dart';
import 'package:merchant_dashboard/feature/dashboard/data/models/responses/sales/sales_statistics_response.dart';
import 'package:merchant_dashboard/feature/dashboard/data/models/responses/top_items/top_sales_data_response.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../core/client/request_cancel_token.dart';
import '../../../../core/constants/defaults.dart';
import '../../../../core/utils/exceptions.dart';
import '../../../orders/data/models/response/top_last/top_last_orders_response.dart';
import '../models/responses/orders_statistics/orders_statistics_response.dart';
import '../models/responses/top_sub_categories/top_sub_categories_item_response.dart';
import '../models/responses/worker/worker_sales_response.dart';

abstract class IDashboardRemoteDataSource {
  Future<SalesPerTimelineResponse?> getSalesPerToday([DashboardDataParameter? dashboardParameter]);

  Future<SalesPerTimelineResponse?> getSalesPerWeek([DashboardDataParameter? dashboardParameter]);

  Future<SalesPerTimelineResponse?> getSalesPerMonth([DashboardDataParameter? dashboardParameter]);

  Future<SalesPerTimelineResponse?> getSalesPerDate(DashboardDataParameter dashboardParameter);

  Future<SalesPerTimelineResponse?> getOrdersPerToday([DashboardDataParameter? dashboardParameter]);

  Future<SalesPerTimelineResponse?> getOrdersPerWeek([DashboardDataParameter? dashboardParameter]);

  Future<SalesPerTimelineResponse?> getOrdersPerMonth([DashboardDataParameter? dashboardParameter]);

  Future<SalesPerTimelineResponse?> getOrdersPerDate(DashboardDataParameter dashboardParameter);

  Future<SalesStatisticsResponse> getSalesStatisticsPerToday([DashboardDataParameter? dashboardParameter]);

  Future<SalesStatisticsResponse> getSalesStatisticsPerWeek([DashboardDataParameter? dashboardParameter]);

  Future<SalesStatisticsResponse> getSalesStatisticsPerMonth([DashboardDataParameter? dashboardParameter]);

  Future<SalesStatisticsResponse> getSalesStatisticsPerDate(DashboardDataParameter dashboardParameter);

  Future<OrdersStatisticsResponse> getOrdersStatisticsPerToday([DashboardDataParameter? dashboardParameter]);

  Future<OrdersStatisticsResponse> getOrdersStatisticsPerWeek([DashboardDataParameter? dashboardParameter]);

  Future<OrdersStatisticsResponse> getOrdersStatisticsPerMonth([DashboardDataParameter? dashboardParameter]);

  Future<OrdersStatisticsResponse> getOrdersStatisticsPerDate(DashboardDataParameter dashboardParameter);

  Future<TopSalesResponse> getTopSalesPerToday(DashboardDataParameter dashboardParameter);

  Future<TopSalesResponse> getTopOrderSalesPerToday(DashboardDataParameter dashboardParameter);

  Future<TopSalesResponse> getTopSalesPerWeek(DashboardDataParameter dashboardParameter);

  Future<TopSalesResponse> getTopOrderSalesPerWeek(DashboardDataParameter dashboardParameter);

  Future<TopSalesResponse> getTopSalesPerMonth(DashboardDataParameter dashboardParameter);

  Future<TopSalesResponse> getTopOrderSalesPerMonth(DashboardDataParameter dashboardParameter);

  Future<TopSalesResponse> getTopSalesPerDate(DashboardDataParameter dashboardParameter);

  Future<TopSalesResponse> getTopOrderSalesPerDateRange(DashboardDataParameter dashboardParameter);

  Future<ReportsResponse> getReportsPerToday([DashboardDataParameter? dashboardParameter]);

  Future<ReportsResponse> getReportsPerWeek([DashboardDataParameter? dashboardParameter]);

  Future<ReportsResponse> getReportsPerMonth([DashboardDataParameter? dashboardParameter]);

  Future<ReportsResponse> getReportsPerDate(DashboardDataParameter dashboardParameter);

  Future<TopSubCategoriesResponse> getTopSubCategoriesPerToday(DashboardDataParameter dashboardParameter);

  Future<TopSubCategoriesResponse> getTopOrderSubCategoriesPerToday(
      DashboardDataParameter dashboardParameter);

  Future<TopSubCategoriesResponse> getTopSubCategoriesPerWeek(DashboardDataParameter dashboardParameter);

  Future<TopSubCategoriesResponse> getTopOrderSubCategoriesPerWeek(DashboardDataParameter dashboardParameter);

  Future<TopSubCategoriesResponse> getTopSubCategoriesPerMonth(DashboardDataParameter dashboardParameter);

  Future<TopSubCategoriesResponse> getTopOrderSubCategoriesPerMonth(
      DashboardDataParameter dashboardParameter);

  Future<TopSubCategoriesResponse> getTopSubCategoriesPerDate(DashboardDataParameter dashboardParameter);

  Future<TopSubCategoriesResponse> getTopOrderSubCategoriesPerDate(DashboardDataParameter dashboardParameter);

  Future<WorkerSalesResponse> getWorkerSalesPerToday([DashboardDataParameter? dashboardParameter]);
  Future<WorkerSalesResponse> getWorkerSalesPerWeek([DashboardDataParameter? dashboardParameter]);
  Future<WorkerSalesResponse> getWorkerSalesPerMonth([DashboardDataParameter? dashboardParameter]);
  Future<WorkerSalesResponse> getWorkerSalesPerDateRange(DashboardDataParameter dashboardParameter);


  Future<List<TopLastOrdersResponse>> getTransactionOrdersPerToday([DashboardDataParameter? dashboardParameter]);
  Future<List<TopLastOrdersResponse>> getTransactionOrdersPerWeek([DashboardDataParameter? dashboardParameter]);
  Future<List<TopLastOrdersResponse>> getTransactionOrdersPerDate(DashboardDataParameter dashboardParameter);
  Future<List<TopLastOrdersResponse>> getTransactionOrdersPerMonth([DashboardDataParameter? dashboardParameter]);
}

@LazySingleton(as: IDashboardRemoteDataSource)
class DashboardRemoteDataSource extends IDashboardRemoteDataSource with RequestCancelToken {
  final Dio _dioClient;

  DashboardRemoteDataSource(this._dioClient);



  //...Transactions
  @override
  Future<List<TopLastOrdersResponse>> getTransactionOrdersPerToday([DashboardDataParameter? dashboardParameter]) async {
    try {
      // cancelAllRequests();

      final cancelToken = getCancelToken('TodayTopOrderedItems');
      final Response response = await _dioClient.get(
        "Dashboard/TodayTopOrderedItems",
        cancelToken: cancelToken,
        queryParameters: (dashboardParameter ?? DashboardDataParameter()).toJson(),
      );
      if (response.statusCode == 200 && response.data != null) {
        final List<TopLastOrdersResponse> topLastOrdersResponse =
        response.data.map<TopLastOrdersResponse>((data) => TopLastOrdersResponse.fromJson(data)).toList();

        return topLastOrdersResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      if (error.message == Defaults.canceledRequest) {
        throw const RequestException("Force canceled");
      }
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<List<TopLastOrdersResponse>> getTransactionOrdersPerWeek([DashboardDataParameter? dashboardParameter]) async {
    try {
      // cancelAllRequests();

      final cancelToken = getCancelToken('getOrdersPerWeek');
      final Response response = await _dioClient.get(
        "Dashboard/ThisWeekTopOrderedItems",
        cancelToken: cancelToken,
        queryParameters: (dashboardParameter ?? DashboardDataParameter()).toJson(),
      );
      if (response.statusCode == 200 && response.data != null) {
        final List<TopLastOrdersResponse> topLastOrdersResponse =
        response.data.map<TopLastOrdersResponse>((data) => TopLastOrdersResponse.fromJson(data)).toList();

        return topLastOrdersResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      if (error.message == Defaults.canceledRequest) {
        throw const RequestException("Force canceled");
      }
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<List<TopLastOrdersResponse>> getTransactionOrdersPerDate(DashboardDataParameter dashboardParameter) async {
    try {
      // cancelAllRequests();

      final cancelToken = getCancelToken('TopOrderedItems');
      final Response response = await _dioClient.get(
        "Dashboard/TopOrderedItems",
        queryParameters: dashboardParameter.toJson(),
        cancelToken: cancelToken,
      );
      if (response.statusCode == 200 && response.data != null) {
        final List<TopLastOrdersResponse> topLastOrdersResponse =
        response.data.map<TopLastOrdersResponse>((data) => TopLastOrdersResponse.fromJson(data)).toList();

        return topLastOrdersResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      if (error.message == Defaults.canceledRequest) {
        throw const RequestException("Force canceled");
      }
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<List<TopLastOrdersResponse>> getTransactionOrdersPerMonth([DashboardDataParameter? dashboardParameter]) async {
    try {
      cancelAllRequests();

      final cancelToken = getCancelToken('ThisMonthTopOrderedItems');
      final Response response = await _dioClient.get(
        "Dashboard/ThisMonthTopOrderedItems",
        cancelToken: cancelToken,
        queryParameters: (dashboardParameter ?? DashboardDataParameter()).toJson(),
      );
      if (response.statusCode == 200 && response.data != null) {
        final List<TopLastOrdersResponse> topLastOrdersResponse =
        response.data.map<TopLastOrdersResponse>((data) => TopLastOrdersResponse.fromJson(data)).toList();

        return topLastOrdersResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      if (error.message == Defaults.canceledRequest) {
        throw const RequestException("Force canceled");
      }
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }


  @override
  Future<SalesPerTimelineResponse?> getSalesPerToday([DashboardDataParameter? dashboardParameter]) async {
    try {
      // cancelAllRequests();

      final cancelToken = getCancelToken('TodaySalesPerDate');
      final Response response = await _dioClient.get("Dashboard/TodaySalesPerDate",
          queryParameters: (dashboardParameter ?? DashboardDataParameter()).toJson(),
          cancelToken: cancelToken);

      if (response.statusCode == 200) {
        final SalesPerTimelineResponse convertedResponse = SalesPerTimelineResponse.fromJson(response.data);
        return convertedResponse;
      }
      return null;
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<SalesPerTimelineResponse?> getSalesPerWeek([DashboardDataParameter? dashboardParameter]) async {
    try {
      // cancelAllRequests();

      final cancelToken = getCancelToken('ThisWeekSalesPerDate');
      final Response response = await _dioClient.get("Dashboard/ThisWeekSalesPerDate",
          queryParameters: (dashboardParameter ?? DashboardDataParameter()).toJson(),
          cancelToken: cancelToken);

      if (response.statusCode == 200) {
        final SalesPerTimelineResponse convertedResponse = SalesPerTimelineResponse.fromJson(response.data);
        return convertedResponse;
      }
      return null;
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<SalesPerTimelineResponse?> getSalesPerMonth([DashboardDataParameter? dashboardParameter]) async {
    try {
      // cancelAllRequests();

      final cancelToken = getCancelToken('ThisMonthSalesPerDate');
      final Response response = await _dioClient.get("Dashboard/ThisMonthSalesPerDate",
          queryParameters: (dashboardParameter ?? DashboardDataParameter()).toJson(),
          cancelToken: cancelToken);

      if (response.statusCode == 200) {
        final SalesPerTimelineResponse convertedResponse = SalesPerTimelineResponse.fromJson(response.data);
        return convertedResponse;
      }
      return null;
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<SalesPerTimelineResponse?> getSalesPerDate(DashboardDataParameter dashboardParameter) async {
    try {
      // cancelAllRequests();

      final cancelToken = getCancelToken('SalesPerDate');
      final Response response = await _dioClient.get("Dashboard/SalesPerDate",
          queryParameters: dashboardParameter.toJson(), cancelToken: cancelToken);

      if (response.statusCode == 200) {
        final SalesPerTimelineResponse convertedResponse = SalesPerTimelineResponse.fromJson(response.data);
        return convertedResponse;
      }
      return null;
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<SalesPerTimelineResponse?> getOrdersPerToday([DashboardDataParameter? dashboardParameter]) async {
    try {
      final cancelToken = getCancelToken('TodayOrdersPerDate');
      final Response response = await _dioClient.get("Dashboard/TodayOrdersPerDate",
          queryParameters: (dashboardParameter ?? DashboardDataParameter()).toJson(),
          cancelToken: cancelToken);

      if (response.statusCode == 200) {
        final SalesPerTimelineResponse convertedResponse = SalesPerTimelineResponse.fromJson(response.data);
        return convertedResponse;
      }
      return null;
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<SalesPerTimelineResponse?> getOrdersPerWeek([DashboardDataParameter? dashboardParameter]) async {
    try {
      final cancelToken = getCancelToken('ThisWeekOrdersPerDate');
      final Response response = await _dioClient.get("Dashboard/ThisWeekOrdersPerDate",
          queryParameters: (dashboardParameter ?? DashboardDataParameter()).toJson(),
          cancelToken: cancelToken);

      if (response.statusCode == 200) {
        final SalesPerTimelineResponse convertedResponse = SalesPerTimelineResponse.fromJson(response.data);
        return convertedResponse;
      }
      return null;
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<SalesPerTimelineResponse?> getOrdersPerMonth([DashboardDataParameter? dashboardParameter]) async {
    try {
      final cancelToken = getCancelToken('ThisMonthOrdersPerDate');
      final Response response = await _dioClient.get("Dashboard/ThisMonthOrdersPerDate",
          queryParameters: (dashboardParameter ?? DashboardDataParameter()).toJson(),
          cancelToken: cancelToken);

      if (response.statusCode == 200) {
        final SalesPerTimelineResponse convertedResponse = SalesPerTimelineResponse.fromJson(response.data);
        return convertedResponse;
      }
      return null;
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<SalesPerTimelineResponse?> getOrdersPerDate(DashboardDataParameter dashboardParameter) async {
    try {
      final cancelToken = getCancelToken('OrdersPerDate');
      final Response response = await _dioClient.get("Dashboard/OrdersPerDate",
          queryParameters: dashboardParameter.toJson(), cancelToken: cancelToken);

      if (response.statusCode == 200) {
        final SalesPerTimelineResponse convertedResponse = SalesPerTimelineResponse.fromJson(response.data);
        return convertedResponse;
      }
      return null;
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<SalesStatisticsResponse> getSalesStatisticsPerDate(DashboardDataParameter dashboardParameter) async {
    try {
      final cancelToken = getCancelToken('SalesStatistics');
      final Response response = await _dioClient.get("Dashboard/SalesStatistics",
          queryParameters: dashboardParameter.toJson(), cancelToken: cancelToken);

      if (response.statusCode == 200) {
        final SalesStatisticsResponse convertedResponse = SalesStatisticsResponse.fromJson(response.data);
        return convertedResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<SalesStatisticsResponse> getSalesStatisticsPerMonth(
      [DashboardDataParameter? dashboardParameter]) async {
    try {
      final cancelToken = getCancelToken('ThisMonthSalesStatistics');
      final Response response = await _dioClient.get("Dashboard/ThisMonthSalesStatistics",
          queryParameters: (dashboardParameter ?? DashboardDataParameter()).toJson(),
          cancelToken: cancelToken);

      if (response.statusCode == 200) {
        final SalesStatisticsResponse convertedResponse = SalesStatisticsResponse.fromJson(response.data);
        return convertedResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<SalesStatisticsResponse> getSalesStatisticsPerToday(
      [DashboardDataParameter? dashboardParameter]) async {
    try {
      final cancelToken = getCancelToken('TodaySalesStatistics');
      final Response response = await _dioClient.get("Dashboard/TodaySalesStatistics",
          queryParameters: (dashboardParameter ?? DashboardDataParameter()).toJson(),
          cancelToken: cancelToken);

      if (response.statusCode == 200) {
        final SalesStatisticsResponse convertedResponse = SalesStatisticsResponse.fromJson(response.data);
        return convertedResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<SalesStatisticsResponse> getSalesStatisticsPerWeek(
      [DashboardDataParameter? dashboardParameter]) async {
    try {
      final cancelToken = getCancelToken('ThisWeekSalesStatistics');
      final Response response = await _dioClient.get("Dashboard/ThisWeekSalesStatistics",
          queryParameters: (dashboardParameter ?? DashboardDataParameter()).toJson(),
          cancelToken: cancelToken);

      if (response.statusCode == 200) {
        final SalesStatisticsResponse convertedResponse = SalesStatisticsResponse.fromJson(response.data);
        return convertedResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<TopSalesResponse> getTopSalesPerDate(DashboardDataParameter dashboardParameter) async {
    try {
      final cancelToken = getCancelToken('TopSalesItems');
      final Response response = await _dioClient.get("Dashboard/TopSalesItems",
          queryParameters: dashboardParameter.pieChartParametertToJson(), cancelToken: cancelToken);

      if (response.statusCode == 200) {
        final TopSalesResponse convertedResponse = TopSalesResponse.fromJson(response.data);
        return convertedResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<TopSalesResponse> getTopOrderSalesPerDateRange(DashboardDataParameter dashboardParameter) async {
    try {
      final cancelToken = getCancelToken('TopOrderedItems');
      final Response response = await _dioClient.get("Dashboard/TopOrderedItemsStatistics",
          queryParameters: dashboardParameter.pieChartParametertToJson(), cancelToken: cancelToken);

      if (response.statusCode == 200) {
        final TopSalesResponse convertedResponse = TopSalesResponse.fromJson(response.data);
        return convertedResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<TopSalesResponse> getTopSalesPerMonth(DashboardDataParameter dashboardParameter) async {
    try {
      final cancelToken = getCancelToken('ThisMonthTopSalesItems');
      final Response response = await _dioClient.get("Dashboard/ThisMonthTopSalesItems",
          queryParameters: dashboardParameter.pieChartParametertToJson(), cancelToken: cancelToken);

      if (response.statusCode == 200) {
        final TopSalesResponse convertedResponse = TopSalesResponse.fromJson(response.data);
        return convertedResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<TopSalesResponse> getTopOrderSalesPerMonth(DashboardDataParameter dashboardParameter) async {
    try {
      final cancelToken = getCancelToken('ThisMonthTopOrderedItems');
      final Response response = await _dioClient.get("Dashboard/ThisMonthTopOrderedItemsStatistics",
          queryParameters: dashboardParameter.pieChartParametertToJson(), cancelToken: cancelToken);

      if (response.statusCode == 200) {
        final TopSalesResponse convertedResponse = TopSalesResponse.fromJson(response.data);
        return convertedResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<TopSalesResponse> getTopSalesPerToday(DashboardDataParameter dashboardParameter) async {
    try {
      final cancelToken = getCancelToken('TodayTopSalesItems');
      final Response response = await _dioClient.get("Dashboard/TodayTopSalesItems",
          queryParameters: dashboardParameter.pieChartParametertToJson(), cancelToken: cancelToken);

      if (response.statusCode == 200) {
        final TopSalesResponse convertedResponse = TopSalesResponse.fromJson(response.data);
        return convertedResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<TopSalesResponse> getTopOrderSalesPerToday(DashboardDataParameter dashboardParameter) async {
    try {
      final cancelToken = getCancelToken('TodayTopOrderedItemsS');
      final Response response = await _dioClient.get("Dashboard/TodayTopOrderedItemsStatistics",
          queryParameters: dashboardParameter.pieChartParametertToJson(), cancelToken: cancelToken);

      if (response.statusCode == 200) {
        final TopSalesResponse convertedResponse = TopSalesResponse.fromJson(response.data);
        return convertedResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<TopSalesResponse> getTopSalesPerWeek(DashboardDataParameter dashboardParameter) async {
    try {
      final cancelToken = getCancelToken('ThisWeekTopSalesItems');
      final Response response = await _dioClient.get("Dashboard/ThisWeekTopSalesItems",
          queryParameters: dashboardParameter.pieChartParametertToJson(), cancelToken: cancelToken);

      if (response.statusCode == 200) {
        final TopSalesResponse convertedResponse = TopSalesResponse.fromJson(response.data);
        return convertedResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<TopSalesResponse> getTopOrderSalesPerWeek(DashboardDataParameter dashboardParameter) async {
    try {
      final cancelToken = getCancelToken('ThisWeekTopOrderedItems');
      final Response response = await _dioClient.get("Dashboard/ThisWeekTopOrderedItemsStatistics",
          queryParameters: dashboardParameter.pieChartParametertToJson(), cancelToken: cancelToken);

      if (response.statusCode == 200) {
        final TopSalesResponse convertedResponse = TopSalesResponse.fromJson(response.data);
        return convertedResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<ReportsResponse> getReportsPerDate(DashboardDataParameter dashboardParameter) async {
    try {
      final cancelToken = getCancelToken('EachCashierSales');
      final Response response = await _dioClient.get("Dashboard/EachCashierSales",
          queryParameters: dashboardParameter.toJson(), cancelToken: cancelToken);

      if (response.statusCode == 200) {
        final ReportsResponse convertedResponse = ReportsResponse.fromJson(response.data);
        return convertedResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<ReportsResponse> getReportsPerMonth([DashboardDataParameter? dashboardParameter]) async {
    try {
      final cancelToken = getCancelToken('ThisMonthEachCashierSales');
      final Response response = await _dioClient.get("Dashboard/ThisMonthEachCashierSales",
          queryParameters: (dashboardParameter ?? DashboardDataParameter()).toJson(),
          cancelToken: cancelToken);

      if (response.statusCode == 200) {
        final ReportsResponse convertedResponse = ReportsResponse.fromJson(response.data);
        return convertedResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<ReportsResponse> getReportsPerToday([DashboardDataParameter? dashboardParameter]) async {
    try {
      final cancelToken = getCancelToken('TodayEachCashierSales');
      final Response response = await _dioClient.get("Dashboard/TodayEachCashierSales",
          queryParameters: (dashboardParameter ?? DashboardDataParameter()).toJson(),
          cancelToken: cancelToken);

      if (response.statusCode == 200) {
        final ReportsResponse convertedResponse = ReportsResponse.fromJson(response.data);
        return convertedResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<ReportsResponse> getReportsPerWeek([DashboardDataParameter? dashboardParameter]) async {
    try {
      final cancelToken = getCancelToken('ThisWeekEachCashierSales');
      final Response response = await _dioClient.get("Dashboard/ThisWeekEachCashierSales",
          queryParameters: (dashboardParameter ?? DashboardDataParameter()).toJson(),
          cancelToken: cancelToken);

      if (response.statusCode == 200) {
        final ReportsResponse convertedResponse = ReportsResponse.fromJson(response.data);
        return convertedResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<TopSubCategoriesResponse> getTopSubCategoriesPerDate(
      DashboardDataParameter dashboardParameter) async {
    try {
      final cancelToken = getCancelToken('TopSubCategorySales');
      final Response response = await _dioClient.get("Dashboard/TopSubCategorySales",
          queryParameters: dashboardParameter.pieChartParametertToJson(), cancelToken: cancelToken);

      if (response.statusCode == 200) {
        final TopSubCategoriesResponse convertedResponse = TopSubCategoriesResponse.fromJson(response.data);
        return convertedResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<TopSubCategoriesResponse> getTopOrderSubCategoriesPerDate(
      DashboardDataParameter dashboardParameter) async {
    try {
      final cancelToken = getCancelToken('TopOrderedSubcategoryStatistics');
      final Response response = await _dioClient.get("Dashboard/TopOrderedSubcategoryStatistics",
          queryParameters: dashboardParameter.pieChartParametertToJson(), cancelToken: cancelToken);

      if (response.statusCode == 200) {
        final TopSubCategoriesResponse convertedResponse = TopSubCategoriesResponse.fromJson(response.data);
        return convertedResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<TopSubCategoriesResponse> getTopSubCategoriesPerMonth(
      DashboardDataParameter dashboardParameter) async {
    try {
      final cancelToken = getCancelToken('ThisMonthTopSubcategorySales');
      final Response response = await _dioClient.get("Dashboard/ThisMonthTopSubcategorySales",
          queryParameters: dashboardParameter.pieChartParametertToJson(), cancelToken: cancelToken);

      if (response.statusCode == 200) {
        final TopSubCategoriesResponse convertedResponse = TopSubCategoriesResponse.fromJson(response.data);
        return convertedResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<TopSubCategoriesResponse> getTopOrderSubCategoriesPerMonth(
      DashboardDataParameter dashboardParameter) async {
    try {
      final cancelToken = getCancelToken('ThisMonthTopOrderedSubcategoryStatistics');
      final Response response = await _dioClient.get("Dashboard/ThisMonthTopOrderedSubcategoryStatistics",
          queryParameters: dashboardParameter.pieChartParametertToJson(), cancelToken: cancelToken);

      if (response.statusCode == 200) {
        final TopSubCategoriesResponse convertedResponse = TopSubCategoriesResponse.fromJson(response.data);
        return convertedResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<TopSubCategoriesResponse> getTopSubCategoriesPerToday(
      DashboardDataParameter dashboardParameter) async {
    try {
      final cancelToken = getCancelToken('TodayTopSubcategorySales');
      final Response response = await _dioClient.get("Dashboard/TodayTopSubcategorySales",
          queryParameters: dashboardParameter.pieChartParametertToJson(), cancelToken: cancelToken);

      if (response.statusCode == 200) {
        final TopSubCategoriesResponse convertedResponse = TopSubCategoriesResponse.fromJson(response.data);
        return convertedResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<TopSubCategoriesResponse> getTopOrderSubCategoriesPerToday(
      DashboardDataParameter dashboardParameter) async {
    try {
      final cancelToken = getCancelToken('TodayTopOrderedSubcategoryStatistics');
      final Response response = await _dioClient.get("Dashboard/TodayTopOrderedSubcategoryStatistics",
          queryParameters: dashboardParameter.pieChartParametertToJson(), cancelToken: cancelToken);

      if (response.statusCode == 200) {
        final TopSubCategoriesResponse convertedResponse = TopSubCategoriesResponse.fromJson(response.data);
        return convertedResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<TopSubCategoriesResponse> getTopSubCategoriesPerWeek(
      DashboardDataParameter dashboardParameter) async {
    try {
      final cancelToken = getCancelToken('ThisWeekTopSubcategorySales');
      final Response response = await _dioClient.get("Dashboard/ThisWeekTopSubcategorySales",
          queryParameters: dashboardParameter.pieChartParametertToJson(), cancelToken: cancelToken);

      if (response.statusCode == 200) {
        final TopSubCategoriesResponse convertedResponse = TopSubCategoriesResponse.fromJson(response.data);
        return convertedResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<TopSubCategoriesResponse> getTopOrderSubCategoriesPerWeek(
      DashboardDataParameter dashboardParameter) async {
    try {
      final cancelToken = getCancelToken('ThisWeekTopOrderedSubcategoryStatistics');
      final Response response = await _dioClient.get("Dashboard/ThisWeekTopOrderedSubcategoryStatistics",
          queryParameters: dashboardParameter.pieChartParametertToJson(), cancelToken: cancelToken);

      if (response.statusCode == 200) {
        final TopSubCategoriesResponse convertedResponse = TopSubCategoriesResponse.fromJson(response.data);
        return convertedResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<OrdersStatisticsResponse> getOrdersStatisticsPerDate(
      DashboardDataParameter dashboardParameter) async {
    try {
      final cancelToken = getCancelToken('OrdersStatistics');
      final Response response = await _dioClient.get("Dashboard/OrdersStatistics",
          queryParameters: dashboardParameter.toJson(), cancelToken: cancelToken);

      if (response.statusCode == 200) {
        final OrdersStatisticsResponse convertedResponse = OrdersStatisticsResponse.fromJson(response.data);
        return convertedResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<OrdersStatisticsResponse> getOrdersStatisticsPerMonth(
      [DashboardDataParameter? dashboardParameter]) async {
    try {
      final cancelToken = getCancelToken('ThisMonthOrdersStatistics');
      final Response response = await _dioClient.get("Dashboard/ThisMonthOrdersStatistics",
          queryParameters: (dashboardParameter ?? DashboardDataParameter()).toJson(),
          cancelToken: cancelToken);

      if (response.statusCode == 200) {
        final OrdersStatisticsResponse convertedResponse = OrdersStatisticsResponse.fromJson(response.data);
        return convertedResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<OrdersStatisticsResponse> getOrdersStatisticsPerToday(
      [DashboardDataParameter? dashboardParameter]) async {
    try {
      final cancelToken = getCancelToken('TodayOrdersStatistics');
      final Response response = await _dioClient.get("Dashboard/TodayOrdersStatistics",
          queryParameters: (dashboardParameter ?? DashboardDataParameter()).toJson(),
          cancelToken: cancelToken);

      if (response.statusCode == 200) {
        final OrdersStatisticsResponse convertedResponse =
            OrdersStatisticsResponse.fromJson(response.data is String ? null : response.data);
        return convertedResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<OrdersStatisticsResponse> getOrdersStatisticsPerWeek(
      [DashboardDataParameter? dashboardParameter]) async {
    try {
      final cancelToken = getCancelToken('ThisWeekOrdersStatistics');
      final Response response = await _dioClient.get("Dashboard/ThisWeekOrdersStatistics",
          queryParameters: (dashboardParameter ?? DashboardDataParameter()).toJson(),
          cancelToken: cancelToken);

      if (response.statusCode == 200) {
        final OrdersStatisticsResponse convertedResponse =
            OrdersStatisticsResponse.fromJson(response.data is String ? null : response.data);
        return convertedResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<WorkerSalesResponse> getWorkerSalesPerDateRange(DashboardDataParameter dashboardParameter) async {
    try {
      final cancelToken = getCancelToken('EachWorkerSales');
      final Response response = await _dioClient.get("Dashboard/EachWorkerSales",
          queryParameters: dashboardParameter.toJson(), cancelToken: cancelToken);

      if (response.statusCode == 200) {
        final WorkerSalesResponse convertedResponse = WorkerSalesResponse.fromJson(response.data);
        return convertedResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<WorkerSalesResponse> getWorkerSalesPerMonth([DashboardDataParameter? dashboardParameter]) async {
    try {
      final cancelToken = getCancelToken('ThisMonthEachWorkerSales');
      final Response response = await _dioClient.get("/Dashboard/ThisMonthEachWorkerSales?",
          queryParameters: (dashboardParameter ?? DashboardDataParameter()).toJson(),
          cancelToken: cancelToken);

      if (response.statusCode == 200) {
        final WorkerSalesResponse convertedResponse = WorkerSalesResponse.fromJson(response.data);
        return convertedResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<WorkerSalesResponse> getWorkerSalesPerToday([DashboardDataParameter? dashboardParameter]) async {
    try {
      final cancelToken = getCancelToken('TodayEachWorkerSales');
      final Response response = await _dioClient.get("Dashboard/TodayEachWorkerSales?",
          queryParameters: (dashboardParameter ?? DashboardDataParameter()).toJson(),
          cancelToken: cancelToken);

      if (response.statusCode == 200) {
        final WorkerSalesResponse convertedResponse = WorkerSalesResponse.fromJson(response.data);
        return convertedResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<WorkerSalesResponse> getWorkerSalesPerWeek([DashboardDataParameter? dashboardParameter]) async {
    try {
      final cancelToken = getCancelToken('ThisWeekEachWorkerSales');
      final Response response = await _dioClient.get("/Dashboard/ThisWeekEachWorkerSales?",
          queryParameters: (dashboardParameter ?? DashboardDataParameter()).toJson(),
          cancelToken: cancelToken);

      if (response.statusCode == 200) {
        final WorkerSalesResponse convertedResponse = WorkerSalesResponse.fromJson(response.data);
        return convertedResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }
}
