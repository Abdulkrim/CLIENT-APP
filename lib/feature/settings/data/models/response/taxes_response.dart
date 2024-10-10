import '../../../../signup/data/models/entity/tax.dart';

class TaxItemResponse {
  int? id;
  String? name;
  num? value;

  TaxItemResponse({this.id, this.name, this.value});

  Tax toEntity() => Tax(id ?? 0, name ?? '-', value ?? 0);

  TaxItemResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['value'] = value;
    return data;
  }
}
