import 'package:json_annotation/json_annotation.dart';
import 'package:merchant_dashboard/feature/subscription/data/models/entity/currency_info.dart';

part 'currency_info_response.g.dart';

@JsonSerializable()
class CurrencyInfoResponse {
  int? id;
  String? name;
  String? symbol;

  CurrencyInfoResponse({this.id, this.name, this.symbol});

  factory CurrencyInfoResponse.fromJson(Map<String, dynamic> json) => _$CurrencyInfoResponseFromJson(json);

  CurrencyInfo toEntity() => CurrencyInfo(id: id ?? 0, name: name ?? '', symbol: symbol ?? '');
}
