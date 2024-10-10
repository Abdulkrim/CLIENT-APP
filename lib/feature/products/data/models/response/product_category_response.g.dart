// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_category_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductCategoryItemResponse _$ProductCategoryItemResponseFromJson(
        Map<String, dynamic> json) =>
    ProductCategoryItemResponse(
      categoryId: (json['categoryId'] as num?)?.toInt(),
      categoryNameEN: json['categoryNameEN'] as String?,
      isActive: json['isActive'] as bool?,
      categoryNameAR: json['categoryNameAR'] as String?,
      categoryNameTR: json['categoryNameTR'] as String?,
      categoryNameFR: json['categoryNameFR'] as String?,
      imageUrl: json['imageUrl'] as String?,
      visibleApplications: (json['visibleApplications'] as List<dynamic>?)
          ?.map((e) => ApplicationsResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      itemSubCategories: (json['itemSubCategories'] as List<dynamic>?)
          ?.map((e) => ProductSubCategoryItemResponse.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductCategoryItemResponseToJson(
        ProductCategoryItemResponse instance) =>
    <String, dynamic>{
      'categoryId': instance.categoryId,
      'categoryNameEN': instance.categoryNameEN,
      'categoryNameAR': instance.categoryNameAR,
      'categoryNameTR': instance.categoryNameTR,
      'categoryNameFR': instance.categoryNameFR,
      'isActive': instance.isActive,
      'imageUrl': instance.imageUrl,
      'itemSubCategories': instance.itemSubCategories,
      'visibleApplications': instance.visibleApplications,
    };
