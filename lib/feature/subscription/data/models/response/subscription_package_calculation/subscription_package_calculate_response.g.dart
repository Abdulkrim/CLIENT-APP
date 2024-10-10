// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_package_calculate_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionPackageCalculateResponse
    _$SubscriptionPackageCalculateResponseFromJson(Map<String, dynamic> json) =>
        SubscriptionPackageCalculateResponse(
          id: json['id'] as String?,
          branchId: json['branchId'] as String?,
          payments: json['payments'] as List<dynamic>?,
          isOnTrial: json['isOnTrial'] as bool?,
          packagePrice: json['packagePrice'] as num?,
          taxPrice: json['taxPrice'] as num?,
          extraFeaturesPrice: json['extraFeaturesPrice'] as num?,
          finalPrice: json['finalPrice'] as num?,
          isActive: json['isActive'] as bool?,
          expirationDate: json['expirationDate'] as String?,
          subscriptionDate: json['subscriptionDate'] as String?,
          daysRemaining: (json['daysRemaining'] as num?)?.toInt(),
          currency: json['currency'] == null
              ? null
              : CurrencyInfoResponse.fromJson(
                  json['currency'] as Map<String, dynamic>),
          packageName: json['packageName'] as String?,
        );

Map<String, dynamic> _$SubscriptionPackageCalculateResponseToJson(
        SubscriptionPackageCalculateResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'branchId': instance.branchId,
      'payments': instance.payments,
      'isOnTrial': instance.isOnTrial,
      'packagePrice': instance.packagePrice,
      'taxPrice': instance.taxPrice,
      'extraFeaturesPrice': instance.extraFeaturesPrice,
      'finalPrice': instance.finalPrice,
      'isActive': instance.isActive,
      'expirationDate': instance.expirationDate,
      'subscriptionDate': instance.subscriptionDate,
      'daysRemaining': instance.daysRemaining,
      'currency': instance.currency,
      'packageName': instance.packageName,
    };
