// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceDataResponse _$DeviceDataResponseFromJson(Map<String, dynamic> json) =>
    DeviceDataResponse(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      logo: json['logo'] as String?,
    );

Map<String, dynamic> _$DeviceDataResponseToJson(DeviceDataResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logo': instance.logo,
    };
