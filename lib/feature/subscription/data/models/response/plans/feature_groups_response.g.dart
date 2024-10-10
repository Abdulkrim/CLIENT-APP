// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feature_groups_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeatureGroupsResponse _$FeatureGroupsResponseFromJson(
        Map<String, dynamic> json) =>
    FeatureGroupsResponse(
      featureGroup: json['featureGroup'] as String?,
      features: (json['features'] as List<dynamic>?)
          ?.map((e) => FeatureItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      iconUrl: json['iconUrl'] as String?,
    );

Map<String, dynamic> _$FeatureGroupsResponseToJson(
        FeatureGroupsResponse instance) =>
    <String, dynamic>{
      'featureGroup': instance.featureGroup,
      'features': instance.features,
      'iconUrl': instance.iconUrl,
    };
