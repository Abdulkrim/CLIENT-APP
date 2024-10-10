class ProductsReports {
  final List<ProductItemReport> items;
  final int currentPageNumber;
  final int totalPageCount;

  ProductsReports({
    required this.items,
    required this.currentPageNumber,
    required this.totalPageCount,
  });
}

class ProductItemReport {
  final int itemId;
  final num tax;
  final num total;
  final String itemName;
  final String subcategory;

  ProductItemReport({
    required this.itemId,
    required this.tax,
    required this.total,
    required this.itemName,
    required this.subcategory,
  });
}
