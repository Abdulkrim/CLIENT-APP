import '../product_category_response.dart';

class ProductsHierachyResponse {
  List<ProductCategoryResponse>? items;
  int? currentPageNumber;
  int? totalPageCount;

  ProductsHierachyResponse({this.items, this.currentPageNumber, this.totalPageCount});

  ProductsHierachyResponse.fromJson(Map<String, dynamic> json) {
    if (json['value'] != null) {
      items = <ProductCategoryResponse>[];
      json['value'].forEach((v) {
        items!.add(ProductCategoryResponse.fromJson(v));
      });
    }
    currentPageNumber = json['currentPageNumber'];
    totalPageCount = json['totalPageCount'];
  }
}
