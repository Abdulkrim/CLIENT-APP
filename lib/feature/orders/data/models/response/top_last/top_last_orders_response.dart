import 'package:json_annotation/json_annotation.dart';

part 'top_last_orders_response.g.dart';

@JsonSerializable()
class TopLastOrdersResponse{
  final String id;
  final String branchId;
  final String orderDate;
  final double totalFinalPrice;

  TopLastOrdersResponse({
    required this.id,
    required this.branchId,
    required this.orderDate,
    required this.totalFinalPrice,
  });

  factory TopLastOrdersResponse.fromJson(Map<String, dynamic> json) => _$TopLastOrdersResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TopLastOrdersResponseToJson(this);
}