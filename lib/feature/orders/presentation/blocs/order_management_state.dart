part of 'order_management_bloc.dart';

abstract class OrderManagementState extends Equatable {
  const OrderManagementState();

  @override
  List<Object?> get props => [];
}

class OrderManagementInitial extends OrderManagementState {}

class AllOrdersDataLoadingState extends OrderManagementState {
  const AllOrdersDataLoadingState();
}

class AllOrdersDataSuccessState extends OrderManagementState {
  final bool hasMore;
  final int currentPage;

  const AllOrdersDataSuccessState(this.currentPage, this.hasMore);
}

class Last30DaysInfoDataSuccessState extends OrderManagementState {
  final num? customersCount;
  final num? salesCount;
  final num? ordersCount;
  final num? productsCount;

  const Last30DaysInfoDataSuccessState({this.customersCount, this.salesCount, this.ordersCount, this.productsCount});

  @override
  List<Object?> get props => [customersCount, salesCount, ordersCount, productsCount];
}

class Last30DaysInfoDataFailedState extends OrderManagementState {
  const Last30DaysInfoDataFailedState();
}

class CancelButtonStateChangedState extends OrderManagementState {
  final bool cancelFilterSelected;

  const CancelButtonStateChangedState(this.cancelFilterSelected);

  @override
  List<Object> get props => [cancelFilterSelected];
}

class CompletedButtonStateChangedState extends OrderManagementState {
  final bool completeFilterSelected;

  const CompletedButtonStateChangedState(this.completeFilterSelected);

  @override
  List<Object> get props => [completeFilterSelected];
}

class GetOrderDetailsSuccessState extends OrderManagementState {
  final OrderItem order;

  const GetOrderDetailsSuccessState(this.order);

  @override
  List<Object> get props => [order];
}

class GetOrderDetailsLoadingState extends OrderManagementState {
  const GetOrderDetailsLoadingState();
}

class ChangeOrderStatusLoadingState extends OrderManagementState {
  const ChangeOrderStatusLoadingState();
}

class GetOrdersFailedState extends OrderManagementState {
  final String msg;

  const GetOrdersFailedState(this.msg);

  @override
  List<Object> get props => [msg];
}

class ChangeOrderStatusFailedState extends OrderManagementState {
  final String msg;

  const ChangeOrderStatusFailedState(this.msg);

  @override
  List<Object> get props => [msg];
}

class GetOrderDetailsFailedState extends OrderManagementState {
  final String msg;

  const GetOrderDetailsFailedState(this.msg);

  @override
  List<Object> get props => [msg];
}

class ShowPaymentTypeDialog extends OrderManagementState {
  final List<PaymentType> paymentModes;
  final bool requestedStatusIsCompleted;
  final int requestedStatusId;
  final OrderItem orderItem;

  const ShowPaymentTypeDialog(
      {required this.paymentModes,
      required this.orderItem,
      required this.requestedStatusIsCompleted,
      required this.requestedStatusId});

  @override
  List<Object?> get props => [
        paymentModes,
        orderItem,
        requestedStatusId,
        requestedStatusIsCompleted,
      ];
}
