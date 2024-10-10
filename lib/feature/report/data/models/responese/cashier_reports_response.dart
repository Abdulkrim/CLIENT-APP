import 'package:merchant_dashboard/feature/report/data/models/entity/cashiers_reports.dart';

class CashierReportsResponse {
  List<CashierItemReportResponse>? items;
  int? currentPageNumber;
  int? totalPageCount;

  CashierReportsResponse({this.items, this.currentPageNumber, this.totalPageCount});

  CashierReportsResponse.fromJson(Map<String, dynamic> json)
      : items = (json['value'] as List<dynamic>).map((e) => CashierItemReportResponse.fromJson(e)).toList(),
        currentPageNumber = json['currentPageNumber'],
        totalPageCount = json['totalPageCount'];

  CashiersReports toEntity() => CashiersReports(
      items: items
              ?.map((e) => CashierItemReport(
                  cashierId: e.cashierId ?? '0',
                  cashierName: e.cashierName ?? '',
                  tax: e.tax ?? 0,
                  totalSales: e.toalSell ?? 0))
              .toList() ??
          [],
      currentPageNumber: currentPageNumber ?? 1,
      totalPageCount: totalPageCount ?? 1);
}

class CashierItemReportResponse {
  String? branchId;
  String? branchName;
  String? cashierId;
  String? cashierName;
  num? tax;
  num? toalSell;

  CashierItemReportResponse(
      {this.branchId, this.branchName, this.cashierId, this.cashierName, this.tax, this.toalSell});

  CashierItemReportResponse.fromJson(Map<String, dynamic> json) {
    branchId = json['branchId'];
    branchName = json['branchName'];
    cashierId = json['cashierId'];
    cashierName = json['cashierName'];
    tax = json['tax'];
    toalSell = json['toalSell'];
  }
}
