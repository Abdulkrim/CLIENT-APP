import 'package:merchant_dashboard/feature/report/data/models/entity/sub_categories_reports.dart';

class SubCategoryReportsResponse {
  List<SubCategoryItemReportResponse>? items;
  int? currentPageNumber;
  int? totalPageCount;

  SubCategoryReportsResponse({this.items, this.currentPageNumber, this.totalPageCount});

  SubCategoryReportsResponse.fromJson(Map<String, dynamic> json)
      : items =
            (json['value'] as List<dynamic>).map((e) => SubCategoryItemReportResponse.fromJson(e)).toList(),
        currentPageNumber = json['currentPageNumber'],
        totalPageCount = json['totalPageCount'];

  SubCategoriesReports toEntity() => SubCategoriesReports(
      items: items
              ?.map((e) => SubCategoryItemReport(
                  categoryName: e.categoryName ?? '',
                  subName: e.subName ?? '',
                  subCategoryId: e.subCategoryId ?? 1,
                  tax: e.tax ?? 0,
                  total: e.total ?? 0))
              .toList() ??
          [],
      currentPageNumber: currentPageNumber ?? 0,
      totalPageCount: totalPageCount ?? 0);
}

class SubCategoryItemReportResponse {
  String? branchId;
  String? branchName;
  String? categoryName;
  String? subName;
  int? subCategoryId;
  num? tax;
  num? total;

  SubCategoryItemReportResponse(
      {this.branchId,
      this.branchName,
      this.categoryName,
      this.subName,
      this.subCategoryId,
      this.tax,
      this.total});

  SubCategoryItemReportResponse.fromJson(Map<String, dynamic> json) {
    branchId = json['branchId'];
    branchName = json['branchName'];
    categoryName = json['categoryName'];
    subName = json['subName'];
    subCategoryId = json['subCategoryId'];
    tax = json['tax'];
    total = json['total'];
  }
}
