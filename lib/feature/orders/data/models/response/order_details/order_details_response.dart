import 'package:json_annotation/json_annotation.dart';

import '../../../../../customers/data/models/response/info/customers_response.dart';
import 'order_item_details_response.dart';

part 'order_details_response.g.dart';

@JsonSerializable()
class OrderDetailsResponse {
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
  CustomerInfoResponse? customer;
  CurrentStatusType? currentStatusType;

  OrderDetailsResponse({
    this.id,
    this.totalPrice,
    this.totalTax,
    this.totalDiscount,
    this.totalFinalPrice,
    this.couponDetailId,
    this.businessTypeId,
    this.totalQuantity,
    this.requestedBy,
    this.orderDetails,
    this.orderProcesses,
    this.orderQueue,
    this.customer,
    this.currentStatusType,
  });

  factory OrderDetailsResponse.fromJson(Map<String, dynamic> json) => _$OrderDetailsResponseFromJson(json);
}

class OrderProcesses {
  int? orderStatusTypeId;
  String? operationDate;

  OrderProcesses({this.orderStatusTypeId, this.operationDate});

  OrderProcesses.fromJson(Map<String, dynamic> json) {
    orderStatusTypeId = json['orderStatusTypeId'];
    operationDate = json['operationDate'];
  }

  Map<String, dynamic> toJson() => {
        'orderStatusTypeId': orderStatusTypeId,
        'operationDate': operationDate,
      };
}

class OrderQueue {
  int? queueNumber;

  OrderQueue({this.queueNumber});

  OrderQueue.fromJson(Map<String, dynamic> json) {
    queueNumber = json['queueNumber'];
  }

  Map<String, dynamic> toJson() => {
        'queueNumber': queueNumber,
      };
}

class CurrentStatusType {
  int? id;
  String? title;

  CurrentStatusType({this.id, this.title});

  CurrentStatusType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
      };
}
