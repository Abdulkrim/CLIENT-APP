import 'package:merchant_dashboard/utils/mixins/date_time_utilities.dart';

import '../../../../products/data/models/entity/product_stock.dart';

class Stocks {
  final List<StockInfo> stocks;
  final int currentPageNumber;
  final int totalPageCount;

  Stocks({required this.stocks, required this.currentPageNumber, required this.totalPageCount});
}

class StockInfo with DateTimeUtilities {
  final int id;
  final String itemNameEN;
  final String itemNameAR;
  final String itemNameTR;
  final String itemNameFR;

  final num subCategoryID;
  final String subCategoryNameEn;
  final String subCategoryNameAr;
  final String subCategoryNameTr;
  final String subCategoryNameFr;
  final String barCode;
  final ProductStock? itemStock;

  final num quantity;
  final String image;

  StockInfo({
    required this.id,
    required this.itemNameEN,
    required this.itemNameFR,
    required this.itemNameTR,
    required this.itemNameAR,
    required this.subCategoryID,
    required this.subCategoryNameEn,
    required this.subCategoryNameAr,
    required this.subCategoryNameTr,
    required this.subCategoryNameFr,
    required this.quantity,
    required this.image,
    required this.itemStock,
    required this.barCode,
  });
}
