part of 'order_management_bloc.dart';

abstract class OrderManagementEvent extends Equatable {
  const OrderManagementEvent();

  @override
  List<Object?> get props => [];
}

class GetBranchParametersEvent extends OrderManagementEvent {
  const GetBranchParametersEvent();
}

class GetCashiersEvent extends OrderManagementEvent {
  const GetCashiersEvent();
}

class GetAllOrderRequestEvent extends OrderManagementEvent {
  final bool getMore;
  final int? selectedStatusIdFilter;
  const GetAllOrderRequestEvent({this.getMore = false, this.selectedStatusIdFilter});

  @override
  List<Object?> get props => [getMore, selectedStatusIdFilter];
}

class GetOrderStatusesEvent extends OrderManagementEvent {
  const GetOrderStatusesEvent();
}

class Get30OrderInfoRequestEvent extends OrderManagementEvent {
  const Get30OrderInfoRequestEvent();
}

class GetAllOrdersData extends OrderManagementEvent {
  const GetAllOrdersData();
}

class GetOrderDetailsEvent extends OrderManagementEvent {
  final String orderId;

  const GetOrderDetailsEvent(this.orderId);

  @override
  List<Object> get props => [orderId];
}

class ChangeOrderStatusEvent extends OrderManagementEvent {
  final String? selectedCashierId;
  final String? referenceID;
  final int? selectedPaymentType;
  final num? deliveryDiscount;

  final int requestedStatusId;
  final bool requestedStatusIsCompleted;
  final OrderItem orderItem;

  const ChangeOrderStatusEvent(
      {required this.orderItem,
      required this.requestedStatusIsCompleted,
      required this.requestedStatusId,
      this.selectedCashierId,
      this.deliveryDiscount,
      this.referenceID,
      this.selectedPaymentType});

  @override
  List<Object?> get props => [
        requestedStatusIsCompleted,
        referenceID,
        requestedStatusId,
        selectedCashierId,
        selectedPaymentType,
        orderItem,
      ];
}
