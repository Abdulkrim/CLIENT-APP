class CashiersReports {
  final List<CashierItemReport> items;
  final int currentPageNumber;
  final int totalPageCount;

  CashiersReports({
    required this.items,
    required this.currentPageNumber,
    required this.totalPageCount,
  });
}

class CashierItemReport {
  final String cashierId;
  final String cashierName;
  final num tax;
  final num totalSales;

  CashierItemReport({
    required this.cashierId,
    required this.cashierName,
    required this.tax,
    required this.totalSales,
  });
}
