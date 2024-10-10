// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'areas_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AreaItemResponse _$AreaItemResponseFromJson(Map<String, dynamic> json) =>
    AreaItemResponse(
      id: (json['id'] as num?)?.toInt(),
      branchId: json['branchId'] as String?,
      areaId: (json['areaId'] as num?)?.toInt(),
      minOrderAmount: json['minOrderAmount'] as num?,
      deliveryFee: json['deliveryFee'] as num?,
      maxDeliveryDiscount: json['maxDeliveryDiscount'] as num?,
      area: json['area'] == null
          ? null
          : AreaItemDetailsResponse.fromJson(
              json['area'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AreaItemResponseToJson(AreaItemResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'branchId': instance.branchId,
      'areaId': instance.areaId,
      'minOrderAmount': instance.minOrderAmount,
      'deliveryFee': instance.deliveryFee,
      'maxDeliveryDiscount': instance.maxDeliveryDiscount,
      'area': instance.area,
    };
