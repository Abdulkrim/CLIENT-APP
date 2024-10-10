class SubCategoriesReports {
  final List<SubCategoryItemReport> items;
  final int currentPageNumber;
  final int totalPageCount;

  SubCategoriesReports({
    required this.items,
    required this.currentPageNumber,
    required this.totalPageCount,
  });
}

class SubCategoryItemReport {
  final String categoryName;
  final String subName;
  final int subCategoryId;
  final num tax;
  final num total;

  SubCategoryItemReport({
    required this.categoryName,
    required this.subName,
    required this.subCategoryId,
    required this.tax,
    required this.total,
  });
}
