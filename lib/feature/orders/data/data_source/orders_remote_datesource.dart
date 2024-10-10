import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/core/client/parameter/base_filter_parameter.dart';
import 'package:merchant_dashboard/core/utils/exceptions.dart';
import 'package:merchant_dashboard/feature/orders/data/models/params/change_order_status_parameter.dart';
import 'package:merchant_dashboard/feature/orders/data/models/response/all_orders/pagination_order_response.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../core/client/request_cancel_token.dart';
import '../../../dashboard/data/models/params/merchant_branch_parameter.dart';
import '../models/response/all_orders/order_item_response.dart';
import '../models/response/order_statistics_data/order_statistics_response.dart';
import '../models/response/order_statuses/order_statuses_response.dart';

abstract class IOrdersRemoteDataSource {
  Future<OrderStatusesResponse> getOrderStatuses();

  Future<PaginationOrderResponse> getAllOrders(BaseFilterListParameter parameter);

  Future<OrderItemResponse> getOrderDetails(String orderId);

  Future<bool> changeOrderStatus(ChangeOrderStatusParameter changeOrderStatusParameter);

  Future<OrderStatisticsResponse> getLast30OrderData([MerchantBranchParameter? parameter]);
}

@LazySingleton(as: IOrdersRemoteDataSource)
class OrderRemoteDataSource extends IOrdersRemoteDataSource with RequestCancelToken {
  final Dio _dioClient;

  OrderRemoteDataSource(this._dioClient);

  final Map<String, CancelToken> _cancelTokens = {};

  CancelToken _getCancelToken(String apiName) {
    final cancelToken =
        _cancelTokens.containsKey(apiName) ? cancelRequest(_cancelTokens[apiName]!) : CancelToken();

    _cancelTokens[apiName] = cancelToken;
    return cancelToken;
  }

  @override
  Future<PaginationOrderResponse> getAllOrders(BaseFilterListParameter parameter) async {
    try {
      final cancelToken = _getCancelToken('Order/GetOrders');

      final Response response = await _dioClient.post("Order/GetOrders",
          queryParameters: parameter.branchToJson(), data: parameter.filterToJson(), cancelToken: cancelToken);
      if (response.statusCode == 200 ||response.statusCode == 204) {
        final PaginationOrderResponse ordersResponse = PaginationOrderResponse.fromJson(response.data is String ? {} : response.data);
        return ordersResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<OrderItemResponse> getOrderDetails(String orderId) async {
    try {
      final Response response =
          await _dioClient.get("Order/OrderDetails", queryParameters: {'orderId': orderId});

      if (response.statusCode == 200) {
        final OrderItemResponse ordersResponse = OrderItemResponse.fromJson(response.data);
        return ordersResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<OrderStatisticsResponse> getLast30OrderData([MerchantBranchParameter? parameter]) async {
    try {
      final Response response = await _dioClient.get("Order/TodayOrderStatistics",
          queryParameters: (parameter ?? MerchantBranchParameter()).branchToJson());

      if (response.statusCode == 200) {
        OrderStatisticsResponse convertedJson = OrderStatisticsResponse.fromJson(response.data);
        return (convertedJson);
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<bool> changeOrderStatus(ChangeOrderStatusParameter changeOrderStatusParameter) async {
    try {
      final Response response =
          await _dioClient.patch("Order/ChangeStatus", data: changeOrderStatusParameter.toJson());

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return (true);
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<OrderStatusesResponse> getOrderStatuses() async {
    try {
      final Response response = await _dioClient.get("Order/OrderStatusTypes");

      if (response.statusCode == 200) {
        OrderStatusesResponse convertedJson = OrderStatusesResponse.fromJson(response.data);
        return (convertedJson);
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }
}
