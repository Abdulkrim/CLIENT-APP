import 'package:json_annotation/json_annotation.dart';

import '../../../../products/data/models/response/measure_unit/measure_unit_response.dart';

part 'item_stock_response.g.dart';

@JsonSerializable()
class ItemStockResponse {
  int? id;
  int? quantity;
  int? stockStatus;
  MeasureUnitItemResponse? unitOfMeasure;
  String? physicalLocation;

  ItemStockResponse({this.id, this.quantity, this.stockStatus, this.unitOfMeasure, this.physicalLocation});

  factory ItemStockResponse.fromJson(Map<String, dynamic> json) => _$ItemStockResponseFromJson(json);
}
