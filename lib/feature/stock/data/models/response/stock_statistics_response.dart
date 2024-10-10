import 'package:merchant_dashboard/feature/stock/data/models/entity/stock_statistics.dart';

class StockStatisticsResponse {
  num? totalItems;
  num? totalQuantity;
  num? totalValue;

  StockStatisticsResponse(this.totalItems, this.totalQuantity, this.totalValue);

  StockStatisticsResponse.fromJson(Map<String, dynamic> json)
      : totalItems = json['totalItems'] ?? 0,
        totalQuantity = json['totalQuantity'] ?? 0,
        totalValue = json['totalValue'] ?? 0;

  StockStatistics toEntity() => StockStatistics(
      totalItems: (totalItems ?? 0).toString(),
      totalQuantity: (totalQuantity ?? 0).toString(),
      totalValue: (totalValue ?? 0).toString());
}
