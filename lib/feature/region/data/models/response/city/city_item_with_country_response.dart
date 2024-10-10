import 'package:json_annotation/json_annotation.dart';

import '../country/country_data_response.dart';

part 'city_item_with_country_response.g.dart';


@JsonSerializable()
class CityItemWithCountryResponse{

  int? id;
  String? name;
  CountryDataResponse? country;

  CityItemWithCountryResponse({this.id, this.name, this.country});

  factory CityItemWithCountryResponse.fromJson(Map<String, dynamic> json) => _$CityItemWithCountryResponseFromJson(json);
}