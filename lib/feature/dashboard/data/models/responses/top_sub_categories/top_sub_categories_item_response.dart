import 'package:json_annotation/json_annotation.dart';

import '../../entities/top_sale_item.dart';

part 'top_sub_categories_item_response.g.dart';

@JsonSerializable()
class TopSubCategoriesItemResponse {
  int? count;
  num? sumPrices;
  String? categoryNameEn;
  String? categoryNameFr;
  String? categoryNameAr;
  String? categoryNameTr;
  num? percentage;

  TopSubCategoriesItemResponse(
      {this.count,
      this.sumPrices,
      this.categoryNameEn,
      this.categoryNameFr,
      this.categoryNameAr,
      this.categoryNameTr,
      this.percentage});

  factory TopSubCategoriesItemResponse.fromJson(Map<String, dynamic> json) =>
      _$TopSubCategoriesItemResponseFromJson(json);
}

class TopSubCategoriesResponse {
  List<TopSubCategoriesItemResponse> data;

  TopSubCategoriesResponse.fromJson(List<dynamic>? json)
      : data = json?.map((e) => TopSubCategoriesItemResponse.fromJson(e)).toList() ?? [];

  List<TopSaleItem> toEntity() => data
      .map((e) => TopSaleItem(
          count: e.count ?? 0,
          itemNameEN: e.categoryNameEn ?? '',
          itemNameFR: e.categoryNameFr ?? '',
          itemNameAR: e.categoryNameAr ?? '',
          itemNameTR: e.categoryNameTr ?? '',
          percentage: e.percentage ?? 0,
          itemId: 0))
      .toList();
}
