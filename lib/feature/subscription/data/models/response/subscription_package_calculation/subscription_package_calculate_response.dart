import 'package:json_annotation/json_annotation.dart';
import 'package:merchant_dashboard/feature/subscription/data/models/entity/currency_info.dart';
import 'package:merchant_dashboard/feature/subscription/data/models/entity/subscription_package_calculate.dart';

import '../plans/currency_info_response.dart';

part 'subscription_package_calculate_response.g.dart';

@JsonSerializable()
class SubscriptionPackageCalculateResponse {
  String? id;
  String? branchId;
  List<dynamic>? payments;
  bool? isOnTrial;
  num? packagePrice;
  num? taxPrice;
  num? extraFeaturesPrice;
  num? finalPrice;
  bool? isActive;
  String? expirationDate;
  String? subscriptionDate;
  int? daysRemaining;
  CurrencyInfoResponse? currency;
  String? packageName;

  SubscriptionPackageCalculateResponse(
      {this.id,
      this.branchId,
      this.payments,
      this.isOnTrial,
      this.packagePrice,
      this.taxPrice,
      this.extraFeaturesPrice,
      this.finalPrice,
      this.isActive,
      this.expirationDate,
      this.subscriptionDate,
      this.daysRemaining,
      this.currency,
      this.packageName});

  factory SubscriptionPackageCalculateResponse.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionPackageCalculateResponseFromJson(json);

  SubscriptionPackageCalculate toEntity() => SubscriptionPackageCalculate(
      id: id ?? '',
      isOnTrial: isOnTrial ?? false,
      packagePrice: packagePrice ?? 0,
      taxPrice: taxPrice ?? 0,
      extraFeaturesPrice: extraFeaturesPrice ?? 0,
      finalPrice: finalPrice ?? 0,
      isActive: isActive ?? false,
      expirationDate: expirationDate ?? '',
      subscriptionDate: subscriptionDate ?? '',
      daysRemaining: daysRemaining ?? 0,
      currency: currency?.toEntity() ?? CurrencyInfo(id: 0, name: '', symbol: ''),
      packageName: packageName ?? '');
}
