// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockInfoResponse _$StockInfoResponseFromJson(Map<String, dynamic> json) =>
    StockInfoResponse(
      itemId: (json['itemId'] as num?)?.toInt(),
      itemNameEN: json['itemNameEN'] as String?,
      itemNameAR: json['itemNameAR'] as String?,
      itemNameFR: json['itemNameFR'] as String?,
      itemNameTR: json['itemNameTR'] as String?,
      subCategoryId: (json['subCategoryId'] as num?)?.toInt(),
      subCategory: json['subCategory'] == null
          ? null
          : ProductSubCategoryItemResponse.fromJson(
              json['subCategory'] as Map<String, dynamic>),
      barCode: json['barCode'] as String?,
      imageUrl: json['imageUrl'] as String?,
      itemStock: json['itemStock'] == null
          ? null
          : ItemStockResponse.fromJson(
              json['itemStock'] as Map<String, dynamic>),
      canHaveStock: json['canHaveStock'] as bool?,
    );

Map<String, dynamic> _$StockInfoResponseToJson(StockInfoResponse instance) =>
    <String, dynamic>{
      'itemId': instance.itemId,
      'itemNameEN': instance.itemNameEN,
      'itemNameAR': instance.itemNameAR,
      'itemNameFR': instance.itemNameFR,
      'itemNameTR': instance.itemNameTR,
      'imageUrl': instance.imageUrl,
      'barCode': instance.barCode,
      'subCategoryId': instance.subCategoryId,
      'subCategory': instance.subCategory,
      'itemStock': instance.itemStock,
      'canHaveStock': instance.canHaveStock,
    };
