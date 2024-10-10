// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_package_details_item_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionPackageDetailsItemResponse
    _$SubscriptionPackageDetailsItemResponseFromJson(
            Map<String, dynamic> json) =>
        SubscriptionPackageDetailsItemResponse(
          isInTheSelectedPackage: json['isInTheSelectedPackage'] as bool?,
          totalPrice: json['totalPrice'] as num?,
          featuresWithCulture: (json['featuresWithCulture'] as List<dynamic>?)
              ?.map((e) => FeatureWithCultureResponse.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
          id: (json['id'] as num?)?.toInt(),
          featureGroupName: json['featureGroupName'] as String?,
        );

Map<String, dynamic> _$SubscriptionPackageDetailsItemResponseToJson(
        SubscriptionPackageDetailsItemResponse instance) =>
    <String, dynamic>{
      'isInTheSelectedPackage': instance.isInTheSelectedPackage,
      'totalPrice': instance.totalPrice,
      'featuresWithCulture': instance.featuresWithCulture,
      'id': instance.id,
      'featureGroupName': instance.featureGroupName,
    };
