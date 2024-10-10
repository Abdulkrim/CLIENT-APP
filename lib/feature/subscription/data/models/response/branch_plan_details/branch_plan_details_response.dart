import 'package:json_annotation/json_annotation.dart';
import 'package:merchant_dashboard/feature/subscription/data/models/entity/branch_plan_details.dart';
import 'package:merchant_dashboard/feature/subscription/data/models/entity/currency_info.dart';

import '../plans/currency_info_response.dart';

part 'branch_plan_details_response.g.dart';

@JsonSerializable()
class BranchPlanDetailsResponse {
  String? id;
  String? branchId;
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

  BranchPlanDetailsResponse(
      {this.id,
      this.branchId,
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

  factory BranchPlanDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$BranchPlanDetailsResponseFromJson(json);

  BranchPlanDetails toEntity() => BranchPlanDetails(
      id: id ?? '',
      branchId: branchId ?? '',
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
