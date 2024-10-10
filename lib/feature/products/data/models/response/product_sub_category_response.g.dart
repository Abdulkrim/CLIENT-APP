// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_sub_category_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductSubCategoryItemResponse _$ProductSubCategoryItemResponseFromJson(
        Map<String, dynamic> json) =>
    ProductSubCategoryItemResponse(
      subCategoryId: (json['subCategoryId'] as num?)?.toInt(),
      categoryId: (json['categoryId'] as num?)?.toInt(),
      isActive: json['isActive'] as bool?,
      subCategoryNameAR: json['subCategoryNameAR'] as String?,
      subCategoryNameFR: json['subCategoryNameFR'] as String?,
      subCategoryNameTR: json['subCategoryNameTR'] as String?,
      imageUrl: json['imageUrl'] as String?,
      subCategoryNameEN: json['subCategoryNameEN'] as String?,
      visibleApplications: (json['visibleApplications'] as List<dynamic>?)
          ?.map((e) => ApplicationsResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => ProductItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductSubCategoryItemResponseToJson(
        ProductSubCategoryItemResponse instance) =>
    <String, dynamic>{
      'subCategoryId': instance.subCategoryId,
      'categoryId': instance.categoryId,
      'subCategoryNameEN': instance.subCategoryNameEN,
      'subCategoryNameAR': instance.subCategoryNameAR,
      'subCategoryNameTR': instance.subCategoryNameTR,
      'subCategoryNameFR': instance.subCategoryNameFR,
      'isActive': instance.isActive,
      'imageUrl': instance.imageUrl,
      'items': instance.items,
      'visibleApplications': instance.visibleApplications,
    };
