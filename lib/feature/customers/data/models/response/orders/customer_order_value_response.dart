import 'package:json_annotation/json_annotation.dart';
import '../../../../../orders/data/models/response/order_details/order_item_details_response.dart';

part 'customer_order_value_response.g.dart';

@JsonSerializable()
class CustomerOrderValueResponse {
  String? id;
  num? totalPrice;
  num? totalTax;
  num? totalDiscount;
  num? totalFinalPrice;
  num? couponDetailId;
  num? businessTypeId;
  num? totalQuantity;
  String? requestedBy;
  List<OrderItemDetailsResponse>? orderDetails;
  List<OrderProcesses>? orderProcesses;
  OrderQueue? orderQueue;

  String? customer;
  String? branch;

  CustomerOrderValueResponse(
      {this.id,
      this.totalPrice,
      this.totalTax,
      this.orderQueue,
      this.totalDiscount,
      this.totalFinalPrice,
      this.couponDetailId,
      this.businessTypeId,
      this.totalQuantity,
      this.requestedBy,
      this.orderDetails,
      this.customer,
      this.orderProcesses,
      this.branch});

  factory CustomerOrderValueResponse.fromJson(Map<String, dynamic> json) => _$CustomerOrderValueResponseFromJson(json);
}

class OrderProcesses {
  String? operationDate;
  int? orderStatusTypeId;

  OrderProcesses({this.operationDate, this.orderStatusTypeId});

  OrderProcesses.fromJson(Map<String, dynamic> json)
      : operationDate = json['operationDate'],
        orderStatusTypeId = json['orderStatusTypeId'];

  Map<String, dynamic> toJson() => {};
}

class OrderQueue {
  num? queueNumber;

  OrderQueue({this.queueNumber});

  OrderQueue.fromJson(Map<String, dynamic> json) : queueNumber = json['queueNumber'];

  Map<String, dynamic> toJson() => {};
}
