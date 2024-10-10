// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_plans_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionPlansResponse _$SubscriptionPlansResponseFromJson(
        Map<String, dynamic> json) =>
    SubscriptionPlansResponse(
      id: (json['id'] as num?)?.toInt(),
      packageName: json['packageName'] as String?,
      packagePricingWithCulture: json['packagePricingWithCulture'] == null
          ? null
          : PackagePricingWithCultureResponse.fromJson(
              json['packagePricingWithCulture'] as Map<String, dynamic>),
      featureGroups: (json['featureGroups'] as List<dynamic>?)
          ?.map(
              (e) => FeatureGroupsResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      includedPackages: (json['includedPackages'] as List<dynamic>?)
          ?.map((e) =>
              IncludedPackageResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      flag: json['flag'] as String?,
      canBeTrial: json['canBeTrial'] as bool?,
    );

Map<String, dynamic> _$SubscriptionPlansResponseToJson(
        SubscriptionPlansResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'packageName': instance.packageName,
      'packagePricingWithCulture': instance.packagePricingWithCulture,
      'featureGroups': instance.featureGroups,
      'includedPackages': instance.includedPackages,
      'flag': instance.flag,
      'canBeTrial': instance.canBeTrial,
    };
