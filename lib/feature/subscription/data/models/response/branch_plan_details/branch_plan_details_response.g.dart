// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_plan_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BranchPlanDetailsResponse _$BranchPlanDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    BranchPlanDetailsResponse(
      id: json['id'] as String?,
      branchId: json['branchId'] as String?,
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

Map<String, dynamic> _$BranchPlanDetailsResponseToJson(
        BranchPlanDetailsResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'branchId': instance.branchId,
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
