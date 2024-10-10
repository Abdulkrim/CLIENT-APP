import 'package:json_annotation/json_annotation.dart';
import 'package:merchant_dashboard/feature/dashboard/data/models/entities/sales_statistics.dart';

import 'payment_stats_response.dart';

part 'sales_statistics_response.g.dart';

@JsonSerializable()
class SalesStatisticsResponse {
  List<PaymentStatsResponse>? paymentStats;
  num? totalPrice;
  int? totalCount;

  SalesStatisticsResponse({this.paymentStats, this.totalPrice, this.totalCount});

  factory SalesStatisticsResponse.fromJson(Map<String, dynamic> json) =>
      _$SalesStatisticsResponseFromJson(json);

  SalesStatistics toEntity() => SalesStatistics(
      paymentStats
              ?.map((e) => PaymentStatsItem(sumPrice: e.sumPrice ?? 0, paymentType: e.paymentType ?? '-'))
              .toList() ??
          [],
      totalPrice ?? 0,
      totalCount ?? 0);
}
