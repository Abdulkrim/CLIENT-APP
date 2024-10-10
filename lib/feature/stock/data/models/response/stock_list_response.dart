import 'package:json_annotation/json_annotation.dart';

import '../../../../products/data/models/entity/measure_unit.dart';
import '../../../../products/data/models/entity/product_stock.dart';
import '../entity/stocks.dart';
import 'stock_info_response.dart';

part 'stock_list_response.g.dart';

@JsonSerializable()
class StockListResponse {
  @JsonKey(name: 'value')
  List<StockInfoResponse>? stocks;
  int? currentPageNumber;
  int? pageSize;
  int? totalPageCount;

  StockListResponse({this.stocks, this.currentPageNumber, this.pageSize, this.totalPageCount});

  factory StockListResponse.fromJson(Map<String, dynamic> json) => _$StockListResponseFromJson(json);

  Stocks toEntity() => Stocks(
        stocks: stocks
                ?.map((e) => StockInfo(
                      id: e.itemId ?? 0,
                      itemNameEN: e.itemNameEN ?? '',
                      itemNameAR: e.itemNameAR ?? '',
                      itemNameTR: e.itemNameTR ?? '',
                      itemNameFR: e.itemNameFR ?? '',
                      barCode: e.barCode ?? '',
                      itemStock: ProductStock(
                          id: e.itemStock?.id ?? 0,
                          quantity: e.itemStock?.quantity ?? 0,
                          stockStatus: e.itemStock?.stockStatus ?? 0,
                          measureUnit: MeasureUnit(
                              id: e.itemStock?.unitOfMeasure?.id ?? 0,
                              name: e.itemStock?.unitOfMeasure?.name ?? '',
                              symbol: e.itemStock?.unitOfMeasure?.symbol ?? '')),
                      subCategoryID: e.subCategoryId ?? 0,
                      subCategoryNameEn: e.subCategory?.subCategoryNameEN ?? '',
                      subCategoryNameAr: e.subCategory?.subCategoryNameAR ?? '',
                      subCategoryNameTr: e.subCategory?.subCategoryNameTR ?? '',
                      subCategoryNameFr: e.subCategory?.subCategoryNameFR ?? '',
                      quantity: e.itemStock?.quantity ?? 0,
                      image: e.imageUrl ?? '',
                    ))
                .toList() ??
            [],
        currentPageNumber: currentPageNumber ?? 1,
        totalPageCount: totalPageCount ?? 1,
      );
}
