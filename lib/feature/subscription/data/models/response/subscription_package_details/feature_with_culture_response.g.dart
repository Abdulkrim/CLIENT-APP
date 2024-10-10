// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feature_with_culture_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeatureWithCultureResponse _$FeatureWithCultureResponseFromJson(
        Map<String, dynamic> json) =>
    FeatureWithCultureResponse(
      isInTheSelectedPackage: json['isInTheSelectedPackage'] as bool?,
      id: (json['id'] as num?)?.toInt(),
      featureNameWithCulture: json['featureNameWithCulture'] as String?,
      featureGroupId: (json['featureGroupId'] as num?)?.toInt(),
      featurePricingWithCulture: json['featurePricingWithCulture'] == null
          ? null
          : FeaturePricingWithCultureResponse.fromJson(
              json['featurePricingWithCulture'] as Map<String, dynamic>),
      businessTypeId: (json['businessTypeId'] as num?)?.toInt(),
      iconUrl: json['iconUrl'] as String?,
      isDefault: json['isDefault'] as bool?,
    );

Map<String, dynamic> _$FeatureWithCultureResponseToJson(
        FeatureWithCultureResponse instance) =>
    <String, dynamic>{
      'isInTheSelectedPackage': instance.isInTheSelectedPackage,
      'id': instance.id,
      'featureNameWithCulture': instance.featureNameWithCulture,
      'featureGroupId': instance.featureGroupId,
      'featurePricingWithCulture': instance.featurePricingWithCulture,
      'businessTypeId': instance.businessTypeId,
      'iconUrl': instance.iconUrl,
      'isDefault': instance.isDefault,
    };
