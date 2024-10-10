import 'package:json_annotation/json_annotation.dart';
import 'package:merchant_dashboard/feature/products/data/models/entity/products.dart';
import 'package:merchant_dashboard/feature/products/data/models/response/product_item_response.dart';

part 'product_sub_category_response.g.dart';

@JsonSerializable()
class ProductSubCategoryItemResponse {
  final int? subCategoryId;
  final int? categoryId;
  final String? subCategoryNameEN;
  final String? subCategoryNameAR;
  final String? subCategoryNameTR;
  final String? subCategoryNameFR;
  final bool? isActive;
  final String? imageUrl;
  final List<ProductItemResponse>? items;

  final List<ApplicationsResponse>? visibleApplications;

  ProductSubCategoryItemResponse({
    this.subCategoryId,
    this.categoryId,
    this.isActive,
    this.subCategoryNameAR,
    this.subCategoryNameFR,
    this.subCategoryNameTR,
    this.imageUrl,
    this.subCategoryNameEN,
    this.visibleApplications,
    this.items,
  });

  factory ProductSubCategoryItemResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductSubCategoryItemResponseFromJson(json);
}

class ProductSubCategoryResponse {
  List<ProductSubCategoryItemResponse> items;

  ProductSubCategoryResponse(this.items);

  ProductSubCategoryResponse.fromJson(Map<String, dynamic> json)
      : items =
            (json['value'] as List<dynamic>).map((e) => ProductSubCategoryItemResponse.fromJson(e)).toList();

  Map<String, dynamic> toJson() => {};

  List<SubCategory> toEntity() => items
      .map((e) => SubCategory(
          subCategoryId: e.subCategoryId ?? 0,
          categoryId: e.categoryId ?? 0,
          categoryNameEN: e.subCategoryNameEN ?? '',
          categoryNameFR: e.subCategoryNameFR ?? '',
          categoryNameTR: e.subCategoryNameTR ?? '',
          categoryNameAR: e.subCategoryNameAR ?? '',
          visibleApplications:
              e.visibleApplications?.map((e) => e.applicationName ?? '-').toList() ?? <String>[],
          products: e.items?.map((e) => e.toEntity()).toList() ?? [],
          isActive: e.isActive ?? false,
          imageUrl: e.imageUrl ?? ''))
      .toList();
}
