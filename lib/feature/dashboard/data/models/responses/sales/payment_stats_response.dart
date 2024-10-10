import 'package:json_annotation/json_annotation.dart';

part 'payment_stats_response.g.dart';

@JsonSerializable()
class PaymentStatsResponse {
  num? sumPrice;
  String? paymentType;
  int? paymentTypeId;
  int? count;

  PaymentStatsResponse(
      {this.sumPrice, this.paymentType, this.paymentTypeId, this.count});

  factory PaymentStatsResponse.fromJson(Map<String, dynamic> json) => _$PaymentStatsResponseFromJson(json);
}