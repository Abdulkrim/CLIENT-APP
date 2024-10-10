import 'package:json_annotation/json_annotation.dart';

part 'country_data_response.g.dart';

@JsonSerializable()
class CountryDataResponse {
  final int? id;
  final String? name;
  final String? region;
  final String? currency;
  final String? countryCode;
  final String? flagUrl;

  const CountryDataResponse({this.id, this.name, this.currency, this.countryCode, this.flagUrl, this.region});

  factory CountryDataResponse.fromJson(Map<String, dynamic> json) => _$CountryDataResponseFromJson(json);
}
