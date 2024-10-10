import 'package:merchant_dashboard/feature/products/data/models/entity/measure_unit.dart';

class MeasureUnitResponse {
  final List<MeasureUnitItemResponse> items;

  MeasureUnitResponse(this.items);

  MeasureUnitResponse.fromJson(List<dynamic>? json) : items = json?.map((e) => MeasureUnitItemResponse.fromJson(e)).toList() ?? [];

  Map<String, dynamic> toJson() => {};

  List<MeasureUnit> toEntity() => items.map((e) => MeasureUnit(id: e.id ?? 0, name: e.name ?? '', symbol: e.symbol ?? '')).toList();
}

class MeasureUnitItemResponse {
  int? id;
  String? name;
  String? symbol;

  MeasureUnitItemResponse({this.id, this.name, this.symbol});

  MeasureUnitItemResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    symbol = json['symbol'];
  }

  Map<String, dynamic> toJson() => {};
}
