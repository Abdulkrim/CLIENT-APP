import 'package:json_annotation/json_annotation.dart';

import '../../../../products/data/models/response/product_sub_category_response.dart';
import 'item_stock_response.dart';

part 'stock_info_response.g.dart';

@JsonSerializable()
class StockInfoResponse {
  int? itemId;
  String? itemNameEN;
  String? itemNameAR;
  String? itemNameFR;
  String? itemNameTR;
  String? imageUrl;
  String? barCode;
  int? subCategoryId;
  ProductSubCategoryItemResponse? subCategory;
  ItemStockResponse? itemStock;
  bool? canHaveStock;

  StockInfoResponse(
      {this.itemId,
      this.itemNameEN,
      this.itemNameAR,
      this.itemNameFR,
      this.itemNameTR,
      this.subCategoryId,
      this.subCategory,
      this.barCode,
      this.imageUrl,
      this.itemStock,
      this.canHaveStock});

  factory StockInfoResponse.fromJson(Map<String, dynamic> json) => _$StockInfoResponseFromJson(json);
}
