import '../../entity/city.dart';

class CitiesResponse {
  final List<CityItemResponse> cities;

  CitiesResponse(this.cities);

  CitiesResponse.fromJson(List<dynamic>? json)
      : cities = json?.map((e) => CityItemResponse.fromJson(e)).toList() ?? [];

  List<City> toEntity() => cities.map((e) => City(id: e.id ?? 0, name: e.name ?? '-')).toList();
}

class CityItemResponse {
  int? id;
  String? name;
  String? countryName;
  int? countryId;
  String? countryCode;

  CityItemResponse({this.id, this.name, this.countryCode, this.countryId, this.countryName});

  CityItemResponse.fromJson(Map<String, dynamic>? json) {
    id = json?['id'];
    name = json?['name'];
    countryName = json?['countryName'];
    countryId = json?['countryId'];
    countryCode = json?['countryCode'];
  }

  City toEntity() =>
      City(id: id ?? 0, name: name ?? '-', countryId: countryId ?? 0, countryName: countryName ?? '');
}
