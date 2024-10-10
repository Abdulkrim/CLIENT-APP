import '../entity/products_reports.dart';

class ProductReportsResponse {
  List<ProductItemReportResponse>? items;
  int? currentPageNumber;
  int? totalPageCount;

  ProductReportsResponse({this.items, this.currentPageNumber, this.totalPageCount});

  ProductReportsResponse.fromJson(Map<String, dynamic> json)
      : items = (json['value'] as List<dynamic>).map((e) => ProductItemReportResponse.fromJson(e)).toList(),
        currentPageNumber = json['currentPageNumber'],
        totalPageCount = json['totalPageCount'];

  ProductsReports toEntity() => ProductsReports(
      items: items
              ?.map((e) => ProductItemReport(
                  itemId: e.itemId ?? 1,
                  tax: e.tax ?? 0,
                  total: e.total ?? 0,
                  itemName: e.itemName ?? '',
                  subcategory: e.subcategory ?? ''))
              .toList() ??
          [],
      currentPageNumber: currentPageNumber ?? 1,
      totalPageCount: totalPageCount ?? 1);
}

class ProductItemReportResponse {
  String? branchId;
  int? itemId;
  num? tax;
  num? total;
  String? branchName;
  String? itemName;
  String? subcategory;

  ProductItemReportResponse(
      {this.branchId, this.itemId, this.tax, this.total, this.branchName, this.itemName, this.subcategory});

  ProductItemReportResponse.fromJson(Map<String, dynamic> json) {
    branchId = json['branchId'];
    itemId = json['itemId'];
    tax = json['tax'];
    total = json['total'];
    branchName = json['branchName'];
    itemName = json['itemName'];
    subcategory = json['subcategory'];
  }
}
