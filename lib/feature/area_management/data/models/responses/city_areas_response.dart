import 'package:json_annotation/json_annotation.dart';
import 'package:merchant_dashboard/feature/area_management/data/models/entity/area_details.dart';

import '../../../../region/data/models/response/city/city_item_with_country_response.dart';

part 'city_areas_response.g.dart';

@JsonSerializable()
class AreaItemDetailsResponse {
  int? id;
  String? name;
  CityItemWithCountryResponse? city;

  AreaItemDetailsResponse({this.id, this.name, this.city});

  factory AreaItemDetailsResponse.fromJson(Map<String, dynamic> json) => _$AreaItemDetailsResponseFromJson(json);

  AreaDetails toEntity() => AreaDetails(areaId: id ?? 0, areaName: name ?? '', cityId: city?.id ?? 0, cityName: city?.name ?? '');
}

class CityAreasResponse {
  List<AreaItemDetailsResponse> items;

  CityAreasResponse.fromJson(List<dynamic>? json)
      : items = json
                ?.map(
                  (e) => AreaItemDetailsResponse.fromJson(e),
                )
                .toList() ??
            [];

  List<AreaDetails> toEntity() => items
      .map(
        (e) => e.toEntity(),
      )
      .toList();
}
