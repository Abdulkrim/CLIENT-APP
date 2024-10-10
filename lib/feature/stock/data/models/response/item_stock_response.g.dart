// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_stock_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemStockResponse _$ItemStockResponseFromJson(Map<String, dynamic> json) =>
    ItemStockResponse(
      id: (json['id'] as num?)?.toInt(),
      quantity: (json['quantity'] as num?)?.toInt(),
      stockStatus: (json['stockStatus'] as num?)?.toInt(),
      unitOfMeasure: json['unitOfMeasure'] == null
          ? null
          : MeasureUnitItemResponse.fromJson(
              json['unitOfMeasure'] as Map<String, dynamic>),
      physicalLocation: json['physicalLocation'] as String?,
    );

Map<String, dynamic> _$ItemStockResponseToJson(ItemStockResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'quantity': instance.quantity,
      'stockStatus': instance.stockStatus,
      'unitOfMeasure': instance.unitOfMeasure,
      'physicalLocation': instance.physicalLocation,
    };
