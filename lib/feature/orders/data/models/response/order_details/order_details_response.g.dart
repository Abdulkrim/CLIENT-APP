// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDetailsResponse _$OrderDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    OrderDetailsResponse(
      id: json['id'] as String?,
      totalPrice: json['totalPrice'] as num?,
      totalTax: json['totalTax'] as num?,
      totalDiscount: json['totalDiscount'] as num?,
      totalFinalPrice: json['totalFinalPrice'] as num?,
      couponDetailId: json['couponDetailId'] as num?,
      businessTypeId: json['businessTypeId'] as num?,
      totalQuantity: json['totalQuantity'] as num?,
      requestedBy: json['requestedBy'] as String?,
      orderDetails: (json['orderDetails'] as List<dynamic>?)
          ?.map((e) =>
              OrderItemDetailsResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      orderProcesses: (json['orderProcesses'] as List<dynamic>?)
          ?.map((e) => OrderProcesses.fromJson(e as Map<String, dynamic>))
          .toList(),
      orderQueue: json['orderQueue'] == null
          ? null
          : OrderQueue.fromJson(json['orderQueue'] as Map<String, dynamic>),
      customer: json['customer'] == null
          ? null
          : CustomerInfoResponse.fromJson(
              json['customer'] as Map<String, dynamic>),
      currentStatusType: json['currentStatusType'] == null
          ? null
          : CurrentStatusType.fromJson(
              json['currentStatusType'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderDetailsResponseToJson(
        OrderDetailsResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'totalPrice': instance.totalPrice,
      'totalTax': instance.totalTax,
      'totalDiscount': instance.totalDiscount,
      'totalFinalPrice': instance.totalFinalPrice,
      'couponDetailId': instance.couponDetailId,
      'businessTypeId': instance.businessTypeId,
      'totalQuantity': instance.totalQuantity,
      'requestedBy': instance.requestedBy,
      'orderDetails': instance.orderDetails,
      'orderProcesses': instance.orderProcesses,
      'orderQueue': instance.orderQueue,
      'customer': instance.customer,
      'currentStatusType': instance.currentStatusType,
    };
