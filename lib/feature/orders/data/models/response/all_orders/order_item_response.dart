import 'package:json_annotation/json_annotation.dart';

import '../../../../../customers/data/models/response/info/customers_response.dart';
import '../../entity/order_status.dart';
import '../../entity/orders.dart';
import '../../entity/param_object.dart';
import '../order_details/order_item_details_response.dart';
import '../order_statuses/order_statuses_response.dart';

part 'order_item_response.g.dart';

@JsonSerializable()
class OrderItemResponse {
  String? id;
  num? totalPrice;
  num? totalTax;
  num? totalDiscount;
  num? totalFinalPrice;
  num? couponDetailId;
  int? businessTypeId;
  num? totalQuantity;

  int? paymentType;
  String? paymentTypeTitle;
  String? transactionCashierName;
  int? deliveryServiceType;
  String? deliveryServiceTypeTitle;
  String? additionalNote;

  String? requestedBy;
  String? createdAt;
  ParamObjectResponse? param1Object;
  ParamObjectResponse? param2Object;
  ParamObjectResponse? param3Object;
  List<OrderProcessesResponse>? orderProcesses;
  List<OrderStatusItemResponse>? possibleStatusTypes;
  List<OrderItemDetailsResponse>? orderDetails;
  OrderQueueResponse? orderQueue;
  CurrentStatusTypeResponse? currentStatusType;
  String? branch;
  CustomerInfoResponse? customer;
  CustomerOrderedAddressResponse? customerAddress;
  List<TransactionPaymentTypesResposne>? transactionPaymentTypes;
  num? deliveryFinalPrice;
  bool? deliveryDiscountAllowed;
  num? maximumDeliveryDiscount;

  OrderItemResponse(
      {this.id,
      this.totalPrice,
      this.totalTax,
      this.deliveryDiscountAllowed,
      this.deliveryFinalPrice,
      this.maximumDeliveryDiscount,
      this.totalDiscount,
      this.totalFinalPrice,
      this.transactionCashierName,
      this.couponDetailId,
      this.orderDetails,
      this.businessTypeId,
      this.totalQuantity,
      this.requestedBy,
      this.orderProcesses,
      this.orderQueue,
      this.currentStatusType,
      this.createdAt,
      this.possibleStatusTypes,
      this.customer,
      this.customerAddress,
      this.paymentType,
      this.paymentTypeTitle,
      this.additionalNote,
      this.deliveryServiceType,
      this.deliveryServiceTypeTitle,
      this.transactionPaymentTypes,
      this.param1Object,
      this.param2Object,
      this.param3Object,
      this.branch});

  factory OrderItemResponse.fromJson(Map<String, dynamic> json) => _$OrderItemResponseFromJson(json);

  OrderItem toEntity() => OrderItem(
        originalId: id ?? '',
        id: orderQueue?.queueNumber ?? 0,
        createdOn: createdAt ?? '',
        orderDetails: orderDetails?.map((e) => e.toEntity()).toList() ?? [],
        totalFinalPrice: totalFinalPrice ?? 0,
        totalPrice: totalPrice ?? 0,
        userPayTypeDefinedId: paymentType,
        deliveryDiscountAllowed: deliveryDiscountAllowed ?? false,
        deliveryFee: deliveryFinalPrice ?? 0,
        deliveryMaxDiscount: maximumDeliveryDiscount ?? 0,
        paymentTypeTitle: paymentTypeTitle ?? '',
        transactionCashierName: transactionCashierName ?? '',
        deliveryServiceTypeTitle: deliveryServiceTypeTitle ?? '',
        deliveryServiceType: deliveryServiceType ?? 0,
        note: additionalNote ?? '',
        orderedAddress: customerAddress?.fullAddress ?? '',
        lat: customerAddress?.lat ?? 0,
        lng: customerAddress?.lng ?? 0,
        paymentMods: transactionPaymentTypes?.map((e) => e.paymentMode?.paymentModeName ?? '').toList() ?? [],
        customer: customer?.toEntity(),
        queueStatusId: currentStatusType?.id ?? 0,
        queueStatusName: currentStatusType?.title ?? '-',
        totalTax: totalTax ?? 0,
        possibleStatuses: possibleStatusTypes
                ?.map((p) => OrderStatus(p.id ?? 0, p.title ?? '-', p.isCompleted ?? false))
                .toList() ??
            [],
        param1Object: ParamObject(param1Object?.paramHeader ?? '', param1Object?.paramValue ?? '',
            param1Object?.isEnabled ?? 'false'),
        param2Object: ParamObject(param2Object?.paramHeader ?? '', param2Object?.paramValue ?? '',
            param2Object?.isEnabled ?? 'false'),
        param3Object: ParamObject(param3Object?.paramHeader ?? '', param3Object?.paramValue ?? '',
            param3Object?.isEnabled ?? 'false'),
      );
}

class OrderProcessesResponse {
  int? orderStatusTypeId;
  String? operationDate;

  OrderProcessesResponse({this.orderStatusTypeId, this.operationDate});

  OrderProcessesResponse.fromJson(Map<String, dynamic> json) {
    orderStatusTypeId = json['orderStatusTypeId'];
    operationDate = json['operationDate'];
  }

  Map<String, dynamic> toJson() => {};
}

class OrderQueueResponse {
  int? queueNumber;

  OrderQueueResponse({this.queueNumber});

  OrderQueueResponse.fromJson(Map<String, dynamic> json) {
    queueNumber = json['queueNumber'];
  }

  Map<String, dynamic> toJson() => {};
}

class ParamObjectResponse {
  String? paramHeader;
  String? isEnabled;
  String? paramValue;

  ParamObjectResponse({this.paramHeader, this.isEnabled, this.paramValue});

  ParamObjectResponse.fromJson(Map<String, dynamic> json) {
    paramHeader = json['paramHeader'];
    paramValue = json['paramValue'];
    isEnabled = json['isEnabled'];
  }

  Map<String, dynamic> toJson() => {};
}

class CurrentStatusTypeResponse {
  int? id;
  String? title;

  CurrentStatusTypeResponse({this.id, this.title});

  CurrentStatusTypeResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() => {};
}

class CustomerOrderedAddressResponse {
  String? fullAddress;
  num? lat;
  num? lng;

  CustomerOrderedAddressResponse({this.fullAddress, this.lat , this.lng});

  CustomerOrderedAddressResponse.fromJson(Map<String, dynamic> json) {
    fullAddress = json['fullAddress'];
    lat = json['customerLocation']?['latitude'] ;
    lng = json['customerLocation']?['longitude'] ;
  }

  Map<String, dynamic> toJson() => {};
}

class TransactionPaymentTypesResposne {
  num? transactionPaymentId;
  num? amount;
  num? paymentModeId;
  PaymentModeResponse? paymentMode;

  TransactionPaymentTypesResposne(
      {this.amount, this.paymentMode, this.paymentModeId, this.transactionPaymentId});

  TransactionPaymentTypesResposne.fromJson(Map<String, dynamic> json) {
    transactionPaymentId = json['transactionPaymentId'];
    amount = json['amount'];
    paymentModeId = json['paymentModeId'];
    paymentMode = PaymentModeResponse.fromJson(json['paymentMode'] as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() => {};
}

class PaymentModeResponse {
  int? paymentModeId;
  String? paymentModeName;

  PaymentModeResponse({this.paymentModeId, this.paymentModeName});

  PaymentModeResponse.fromJson(Map<String, dynamic> json) {
    paymentModeName = json['paymentModeName'];
    paymentModeId = json['paymentModeId'];
  }

  Map<String, dynamic> toJson() => {};
}
