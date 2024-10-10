// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_item_with_country_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityItemWithCountryResponse _$CityItemWithCountryResponseFromJson(
        Map<String, dynamic> json) =>
    CityItemWithCountryResponse(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      country: json['country'] == null
          ? null
          : CountryDataResponse.fromJson(
              json['country'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CityItemWithCountryResponseToJson(
        CityItemWithCountryResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'country': instance.country,
    };
