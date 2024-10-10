// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItemResponse _$OrderItemResponseFromJson(Map<String, dynamic> json) =>
    OrderItemResponse(
      id: json['id'] as String?,
      totalPrice: json['totalPrice'] as num?,
      totalTax: json['totalTax'] as num?,
      deliveryDiscountAllowed: json['deliveryDiscountAllowed'] as bool?,
      deliveryFinalPrice: json['deliveryFinalPrice'] as num?,
      maximumDeliveryDiscount: json['maximumDeliveryDiscount'] as num?,
      totalDiscount: json['totalDiscount'] as num?,
      totalFinalPrice: json['totalFinalPrice'] as num?,
      transactionCashierName: json['transactionCashierName'] as String?,
      couponDetailId: json['couponDetailId'] as num?,
      orderDetails: (json['orderDetails'] as List<dynamic>?)
          ?.map((e) =>
              OrderItemDetailsResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      businessTypeId: (json['businessTypeId'] as num?)?.toInt(),
      totalQuantity: json['totalQuantity'] as num?,
      requestedBy: json['requestedBy'] as String?,
      orderProcesses: (json['orderProcesses'] as List<dynamic>?)
          ?.map(
              (e) => OrderProcessesResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      orderQueue: json['orderQueue'] == null
          ? null
          : OrderQueueResponse.fromJson(
              json['orderQueue'] as Map<String, dynamic>),
      currentStatusType: json['currentStatusType'] == null
          ? null
          : CurrentStatusTypeResponse.fromJson(
              json['currentStatusType'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as String?,
      possibleStatusTypes: (json['possibleStatusTypes'] as List<dynamic>?)
          ?.map((e) =>
              OrderStatusItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      customer: json['customer'] == null
          ? null
          : CustomerInfoResponse.fromJson(
              json['customer'] as Map<String, dynamic>),
      customerAddress: json['customerAddress'] == null
          ? null
          : CustomerOrderedAddressResponse.fromJson(
              json['customerAddress'] as Map<String, dynamic>),
      paymentType: (json['paymentType'] as num?)?.toInt(),
      paymentTypeTitle: json['paymentTypeTitle'] as String?,
      additionalNote: json['additionalNote'] as String?,
      deliveryServiceType: (json['deliveryServiceType'] as num?)?.toInt(),
      deliveryServiceTypeTitle: json['deliveryServiceTypeTitle'] as String?,
      transactionPaymentTypes:
          (json['transactionPaymentTypes'] as List<dynamic>?)
              ?.map((e) => TransactionPaymentTypesResposne.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
      param1Object: json['param1Object'] == null
          ? null
          : ParamObjectResponse.fromJson(
              json['param1Object'] as Map<String, dynamic>),
      param2Object: json['param2Object'] == null
          ? null
          : ParamObjectResponse.fromJson(
              json['param2Object'] as Map<String, dynamic>),
      param3Object: json['param3Object'] == null
          ? null
          : ParamObjectResponse.fromJson(
              json['param3Object'] as Map<String, dynamic>),
      branch: json['branch'] as String?,
    );

Map<String, dynamic> _$OrderItemResponseToJson(OrderItemResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'totalPrice': instance.totalPrice,
      'totalTax': instance.totalTax,
      'totalDiscount': instance.totalDiscount,
      'totalFinalPrice': instance.totalFinalPrice,
      'couponDetailId': instance.couponDetailId,
      'businessTypeId': instance.businessTypeId,
      'totalQuantity': instance.totalQuantity,
      'paymentType': instance.paymentType,
      'paymentTypeTitle': instance.paymentTypeTitle,
      'transactionCashierName': instance.transactionCashierName,
      'deliveryServiceType': instance.deliveryServiceType,
      'deliveryServiceTypeTitle': instance.deliveryServiceTypeTitle,
      'additionalNote': instance.additionalNote,
      'requestedBy': instance.requestedBy,
      'createdAt': instance.createdAt,
      'param1Object': instance.param1Object,
      'param2Object': instance.param2Object,
      'param3Object': instance.param3Object,
      'orderProcesses': instance.orderProcesses,
      'possibleStatusTypes': instance.possibleStatusTypes,
      'orderDetails': instance.orderDetails,
      'orderQueue': instance.orderQueue,
      'currentStatusType': instance.currentStatusType,
      'branch': instance.branch,
      'customer': instance.customer,
      'customerAddress': instance.customerAddress,
      'transactionPaymentTypes': instance.transactionPaymentTypes,
      'deliveryFinalPrice': instance.deliveryFinalPrice,
      'deliveryDiscountAllowed': instance.deliveryDiscountAllowed,
      'maximumDeliveryDiscount': instance.maximumDeliveryDiscount,
    };
