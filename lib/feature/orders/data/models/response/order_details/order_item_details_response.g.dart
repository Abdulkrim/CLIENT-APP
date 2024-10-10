// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItemDetailsResponse _$OrderItemDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    OrderItemDetailsResponse(
      id: json['id'] as String?,
      originalPrice: json['originalPrice'] as num?,
      discountPrice: json['discountPrice'] as num?,
      taxPrice: json['taxPrice'] as num?,
      finalPrice: json['finalPrice'] as num?,
      quantity: json['quantity'] as num?,
      taxTypeId: json['taxTypeId'] as num?,
      taxValue: json['taxValue'] as num?,
      item: json['item'] == null
          ? null
          : ItemDetailsResponse.fromJson(json['item'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderItemDetailsResponseToJson(
        OrderItemDetailsResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'originalPrice': instance.originalPrice,
      'discountPrice': instance.discountPrice,
      'taxPrice': instance.taxPrice,
      'finalPrice': instance.finalPrice,
      'quantity': instance.quantity,
      'taxTypeId': instance.taxTypeId,
      'taxValue': instance.taxValue,
      'item': instance.item,
    };
