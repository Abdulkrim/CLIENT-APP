// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_sales_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopSalesDataResponse _$TopSalesDataResponseFromJson(
        Map<String, dynamic> json) =>
    TopSalesDataResponse(
      count: (json['count'] as num?)?.toInt(),
      itemNameAR: json['itemNameAR'] as String?,
      itemNameTR: json['itemNameTR'] as String?,
      itemNameFR: json['itemNameFR'] as String?,
      percentage: json['percentage'] as num?,
      itemNameEN: json['itemNameEN'] as String?,
      itemId: (json['itemId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TopSalesDataResponseToJson(
        TopSalesDataResponse instance) =>
    <String, dynamic>{
      'count': instance.count,
      'itemNameAR': instance.itemNameAR,
      'itemNameTR': instance.itemNameTR,
      'itemNameFR': instance.itemNameFR,
      'percentage': instance.percentage,
      'itemNameEN': instance.itemNameEN,
      'itemId': instance.itemId,
    };
