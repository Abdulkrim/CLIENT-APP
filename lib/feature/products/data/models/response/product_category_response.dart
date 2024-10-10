import 'package:json_annotation/json_annotation.dart';
import 'package:merchant_dashboard/feature/products/data/models/entity/products.dart';
import 'package:merchant_dashboard/feature/products/data/models/response/product_sub_category_response.dart';

import 'product_item_response.dart';

part 'product_category_response.g.dart';

@JsonSerializable()
class ProductCategoryItemResponse {
  final int? categoryId;
  final String? categoryNameEN;
  final String? categoryNameAR;
  final String? categoryNameTR;
  final String? categoryNameFR;
  final bool? isActive;
  final String? imageUrl;
  List<ProductSubCategoryItemResponse>? itemSubCategories;

  final List<ApplicationsResponse>? visibleApplications;

  ProductCategoryItemResponse({
    this.categoryId,
    this.categoryNameEN,
    this.isActive,
    this.categoryNameAR,
    this.categoryNameTR,
    this.categoryNameFR,
    this.imageUrl,
    this.visibleApplications,
    this.itemSubCategories,
  });

  factory ProductCategoryItemResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductCategoryItemResponseFromJson(json);
}

class ProductCategoryResponse {
  List<ProductCategoryItemResponse> items;

  ProductCategoryResponse(this.items);

  ProductCategoryResponse.fromJson(Map<String, dynamic> json)
      : items = (json['value'] as List<dynamic>).map((e) => ProductCategoryItemResponse.fromJson(e)).toList();

  Map<String, dynamic> toJson() => {};

  List<ProductsCategory> toEntity() => items
      .map((e) => ProductsCategory(
          categoryId: e.categoryId ?? 0,
          categoryNameEN: e.categoryNameEN ?? '',
          categoryNameFR: e.categoryNameFR ?? '',
          categoryNameTR: e.categoryNameTR ?? '',
          categoryNameAR: e.categoryNameAR ?? '',
          visibleApplications:
              e.visibleApplications?.map((e) => e.applicationName ?? '-').toList() ?? <String>[],
          subCategories: e.itemSubCategories
                  ?.map((s) => SubCategory(
                      subCategoryId: s.subCategoryId ?? 0,
                      categoryId: s.categoryId ?? 0,
                      categoryNameEN: s.subCategoryNameEN ?? '',
                      categoryNameFR: s.subCategoryNameFR ?? '',
                      categoryNameTR: s.subCategoryNameTR ?? '',
                      categoryNameAR: s.subCategoryNameAR ?? '',
                      visibleApplications:
                          s.visibleApplications?.map((e) => e.applicationName ?? '-').toList() ?? <String>[],
                      imageUrl: s.imageUrl ?? '',
                      isActive: s.isActive ?? false,
                      products: s.items?.map((p) => p.toEntity()).toList() ?? []))
                  .toList() ??
              [],
          isActive: e.isActive ?? false,
          imageUrl: e.imageUrl ?? ''))
      .toList();
}
