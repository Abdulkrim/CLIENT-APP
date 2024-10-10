// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_last_orders_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopLastOrdersResponse _$TopLastOrdersResponseFromJson(
        Map<String, dynamic> json) =>
    TopLastOrdersResponse(
      id: json['id'] as String,
      branchId: json['branchId'] as String,
      orderDate: json['orderDate'] as String,
      totalFinalPrice: (json['totalFinalPrice'] as num).toDouble(),
    );

Map<String, dynamic> _$TopLastOrdersResponseToJson(
        TopLastOrdersResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'branchId': instance.branchId,
      'orderDate': instance.orderDate,
      'totalFinalPrice': instance.totalFinalPrice,
    };
