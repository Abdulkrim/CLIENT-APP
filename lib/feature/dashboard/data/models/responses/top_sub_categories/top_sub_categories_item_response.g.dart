// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_sub_categories_item_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopSubCategoriesItemResponse _$TopSubCategoriesItemResponseFromJson(
        Map<String, dynamic> json) =>
    TopSubCategoriesItemResponse(
      count: (json['count'] as num?)?.toInt(),
      sumPrices: json['sumPrices'] as num?,
      categoryNameEn: json['categoryNameEn'] as String?,
      categoryNameFr: json['categoryNameFr'] as String?,
      categoryNameAr: json['categoryNameAr'] as String?,
      categoryNameTr: json['categoryNameTr'] as String?,
      percentage: json['percentage'] as num?,
    );

Map<String, dynamic> _$TopSubCategoriesItemResponseToJson(
        TopSubCategoriesItemResponse instance) =>
    <String, dynamic>{
      'count': instance.count,
      'sumPrices': instance.sumPrices,
      'categoryNameEn': instance.categoryNameEn,
      'categoryNameFr': instance.categoryNameFr,
      'categoryNameAr': instance.categoryNameAr,
      'categoryNameTr': instance.categoryNameTr,
      'percentage': instance.percentage,
    };
