import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/core/constants/defaults.dart';
import 'package:merchant_dashboard/core/utils/exceptions.dart';
import 'package:merchant_dashboard/core/utils/failure.dart';
import 'package:merchant_dashboard/feature/orders/data/data_source/orders_remote_datesource.dart';
import 'package:merchant_dashboard/feature/orders/data/models/entity/order_statistics.dart';
import 'package:merchant_dashboard/feature/orders/data/models/entity/order_status.dart';
import 'package:merchant_dashboard/feature/orders/data/models/entity/orders.dart';
import 'package:merchant_dashboard/feature/orders/data/models/params/change_order_status_parameter.dart';
import 'package:merchant_dashboard/feature/orders/data/models/response/all_orders/pagination_order_response.dart';

import '../../../../core/client/parameter/base_filter_parameter.dart';
import '../models/response/all_orders/order_item_response.dart';
import '../models/response/order_statistics_data/order_statistics_response.dart';

abstract class IOrdersRepository {
  Future<Either<Failure, List<OrderStatus>>> getAllOrderStatuses();

  Future<Either<Failure, OrderListInfo>> getAllOrders({required int currentPage, int? orderStatusIdRequest});

  Future<Either<Failure, OrderItem>> getOrderDetails(String orderId);

  Future<Either<Failure, bool>> changeOrderStatus({
    required String orderId,
    required int statusCode,
    required num totalAmount,
    num? deliveryDiscount,
    int? paymentType,
    String? cashierId,
    String? referenceId,
  });

  Future<Either<Failure, OrderStatistics>> getLast30OrderData();
}

@LazySingleton(as: IOrdersRepository)
class OrdersRepository extends IOrdersRepository {
  final IOrdersRemoteDataSource _ordersRemoteDataSource;

  OrdersRepository(this._ordersRemoteDataSource);

  @override
  Future<Either<Failure, OrderListInfo>> getAllOrders(
      {required int currentPage, int? orderStatusIdRequest}) async {
    try {
      final BaseFilterListParameter parameter = BaseFilterListParameter(filterInfo: [
        if (orderStatusIdRequest != null && orderStatusIdRequest != 0)
          BaseFilterInfoParameter(
              logical: LogicalOperator.and.value,
              propertyName: "CurrentStatusId",
              value: orderStatusIdRequest.toString(),
              operator: QueryOperator.equals.value)
      ], orderInfo: [
        BaseSortInfoParameter(orderType: OrderOperator.desc.value, property: 'CreatedAt')
      ]);

      final PaginationOrderResponse response = await _ordersRemoteDataSource.getAllOrders(parameter);

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, OrderItem>> getOrderDetails(String orderId) async {
    try {
      final OrderItemResponse response = await _ordersRemoteDataSource.getOrderDetails(orderId);

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, OrderStatistics>> getLast30OrderData() async {
    try {
      final OrderStatisticsResponse response = await _ordersRemoteDataSource.getLast30OrderData();

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, bool>> changeOrderStatus({
    required String orderId,
    required int statusCode,
    required num totalAmount,
    int? paymentType,
    num? deliveryDiscount,
    String? cashierId,
    String? referenceId,
  }) async {
    try {
      final bool response = await _ordersRemoteDataSource.changeOrderStatus(ChangeOrderStatusParameter(
          orderId: orderId,
          totalAmount: totalAmount,
          paymentType: paymentType,
          statusCode: statusCode,
          cashierId: cashierId,
          deliveryDiscount: deliveryDiscount ?? 0,
          referenceId: referenceId));

      return Right(response);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, List<OrderStatus>>> getAllOrderStatuses() async {
    try {
      final response = await _ordersRemoteDataSource.getOrderStatuses();

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }
}
