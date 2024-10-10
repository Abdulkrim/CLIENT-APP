import 'package:json_annotation/json_annotation.dart';
import 'package:merchant_dashboard/feature/orders/data/models/entity/order_product.dart';

import 'item_details_response.dart';

part 'order_item_details_response.g.dart';

@JsonSerializable()
class OrderItemDetailsResponse {
  String? id;
  num? originalPrice;
  num? discountPrice;
  num? taxPrice;
  num? finalPrice;
  num? quantity;
  num? taxTypeId;
  num? taxValue;
  ItemDetailsResponse? item;

  OrderItemDetailsResponse(
      {this.id, this.originalPrice, this.discountPrice, this.taxPrice, this.finalPrice, this.quantity, this.taxTypeId, this.taxValue, this.item});

  OrderProduct toEntity() => OrderProduct(
      id: id ?? '',
      originalPrice: originalPrice ?? 0,
      itemNameEN: item?.itemNameEN ?? '',
      itemNameAR: item?.itemNameAR ?? '',
      itemNameFR: item?.itemNameFR ?? '',
      itemNameTR: item?.itemNameTR ?? '',
      quantity: quantity ?? 0);

  factory OrderItemDetailsResponse.fromJson(Map<String, dynamic> json) => _$OrderItemDetailsResponseFromJson(json);
}
