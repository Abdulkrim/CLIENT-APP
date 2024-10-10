// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryDataResponse _$CountryDataResponseFromJson(Map<String, dynamic> json) =>
    CountryDataResponse(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      currency: json['currency'] as String?,
      countryCode: json['countryCode'] as String?,
      flagUrl: json['flagUrl'] as String?,
      region: json['region'] as String?,
    );

Map<String, dynamic> _$CountryDataResponseToJson(
        CountryDataResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'region': instance.region,
      'currency': instance.currency,
      'countryCode': instance.countryCode,
      'flagUrl': instance.flagUrl,
    };
