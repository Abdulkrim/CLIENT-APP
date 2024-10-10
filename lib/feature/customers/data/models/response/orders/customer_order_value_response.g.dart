// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_order_value_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerOrderValueResponse _$CustomerOrderValueResponseFromJson(
        Map<String, dynamic> json) =>
    CustomerOrderValueResponse(
      id: json['id'] as String?,
      totalPrice: json['totalPrice'] as num?,
      totalTax: json['totalTax'] as num?,
      orderQueue: json['orderQueue'] == null
          ? null
          : OrderQueue.fromJson(json['orderQueue'] as Map<String, dynamic>),
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
      customer: json['customer'] as String?,
      orderProcesses: (json['orderProcesses'] as List<dynamic>?)
          ?.map((e) => OrderProcesses.fromJson(e as Map<String, dynamic>))
          .toList(),
      branch: json['branch'] as String?,
    );

Map<String, dynamic> _$CustomerOrderValueResponseToJson(
        CustomerOrderValueResponse instance) =>
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
      'branch': instance.branch,
    };
