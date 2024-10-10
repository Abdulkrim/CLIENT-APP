// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_areas_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AreaItemDetailsResponse _$AreaItemDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    AreaItemDetailsResponse(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      city: json['city'] == null
          ? null
          : CityItemWithCountryResponse.fromJson(
              json['city'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AreaItemDetailsResponseToJson(
        AreaItemDetailsResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'city': instance.city,
    };
