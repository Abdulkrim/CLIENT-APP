import 'package:merchant_dashboard/feature/dashboard/data/models/entities/orders_statistics.dart';

class OrdersStatisticsResponse{
  int? count;
  double? sumPrices;

  OrdersStatisticsResponse({this.count, this.sumPrices});

  OrdersStatisticsResponse.fromJson(Map<String, dynamic>? json) {
    count = json?['count'] ?? 0;
    sumPrices = json?['sumPrices'] ?? 0;
  }

  OrdersStatistics toEntity() =>OrdersStatistics(count ?? 0, sumPrices ?? 0);
}
