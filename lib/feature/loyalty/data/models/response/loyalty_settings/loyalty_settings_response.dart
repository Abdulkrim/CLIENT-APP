import 'package:merchant_dashboard/feature/loyalty/data/models/entity/loyalty_settings.dart';

class LoyaltySettingsResponse {
  bool? loyaltyAllowed;
  double? defaultRechargePointPerCurrency;
  double? branchRechargePointPerCurrency;
  num? defaultRedeemPointPerCurrency;
  num? branchRedeemPointPerCurrency;
  num? defaultExpirePointDurationByDay;
  num? branchExpirePointDurationByDay;
  num? defaultRemainedDaysToExpirePointToNotifyCustomer;
  num? branchRemainedDaysToExpirePointToNotifyCustomer;
  num? defaultMaxExpiringPointToNotifyCustomer;
  num? branchMaxExpiringPointToNotifyCustomer;
  double? defaultMaxPercentOfPayByPoint;
  double? branchMaxPercentOfPayByPoint;
  bool? defaultIsSplitPaymentByPointsAllowed;
  bool? branchIsSplitPaymentByPointsAllowed;

  LoyaltySettingsResponse({
    this.loyaltyAllowed,
    this.defaultRechargePointPerCurrency,
    this.branchRechargePointPerCurrency,
    this.defaultRedeemPointPerCurrency,
    this.branchRedeemPointPerCurrency,
    this.defaultExpirePointDurationByDay,
    this.branchExpirePointDurationByDay,
    this.defaultMaxPercentOfPayByPoint,
    this.branchMaxPercentOfPayByPoint,
    this.defaultIsSplitPaymentByPointsAllowed,
    this.branchIsSplitPaymentByPointsAllowed,
    this.defaultRemainedDaysToExpirePointToNotifyCustomer,
    this.branchRemainedDaysToExpirePointToNotifyCustomer,
    this.defaultMaxExpiringPointToNotifyCustomer,
    this.branchMaxExpiringPointToNotifyCustomer,
  });

  LoyaltySettings toEntity() => LoyaltySettings(
      loyaltyAllowed: loyaltyAllowed ?? false,
      defaultRechargePointPerCurrency: defaultRechargePointPerCurrency ?? 0,
      branchRechargePointPerCurrency: branchRechargePointPerCurrency ?? 0,
      defaultRedeemPointPerCurrency: defaultRedeemPointPerCurrency ?? 0,
      branchRedeemPointPerCurrency: branchRedeemPointPerCurrency ?? 0,
      defaultExpirePointDurationByDay: defaultExpirePointDurationByDay ?? 0,
      branchExpirePointDurationByDay: branchExpirePointDurationByDay ?? 0,
      defaultMaxPercentOfPayByPoint: defaultMaxPercentOfPayByPoint ?? 0,
      branchMaxPercentOfPayByPoint: branchMaxPercentOfPayByPoint ?? 0,
      defaultIsSplitPaymentByPointsAllowed: defaultIsSplitPaymentByPointsAllowed ?? false,
      branchIsSplitPaymentByPointsAllowed: branchIsSplitPaymentByPointsAllowed ?? false,
      defaultRemainedDaysToExpirePointToNotifyCustomer: defaultRemainedDaysToExpirePointToNotifyCustomer ?? 0,
      branchRemainedDaysToExpirePointToNotifyCustomer: branchRemainedDaysToExpirePointToNotifyCustomer ?? 0,
      defaultMaxExpiringPointToNotifyCustomer: defaultMaxExpiringPointToNotifyCustomer ?? 0,
      branchMaxExpiringPointToNotifyCustomer: branchMaxExpiringPointToNotifyCustomer ?? 0);

  LoyaltySettingsResponse.fromJson(Map<String, dynamic> json) {
    loyaltyAllowed = json['loyaltyAllowed'];
    defaultRechargePointPerCurrency = json['defaultRechargePointPerCurrency'];
    branchRechargePointPerCurrency = json['branchRechargePointPerCurrency'];
    defaultRedeemPointPerCurrency = json['defaultRedeemPointPerCurrency'];
    branchRedeemPointPerCurrency = json['branchRedeemPointPerCurrency'];
    defaultExpirePointDurationByDay = json['defaultExpirePointDurationByDay'];
    branchExpirePointDurationByDay = json['branchExpirePointDurationByDay'];
    defaultMaxPercentOfPayByPoint = json['defaultMaxPercentOfPayByPoint'];
    branchMaxPercentOfPayByPoint = json['branchMaxPercentOfPayByPoint'];
    defaultIsSplitPaymentByPointsAllowed = json['defaultIsSplitPaymentByPointsAllowed'];
    branchIsSplitPaymentByPointsAllowed = json['branchIsSplitPaymentByPointsAllowed'];
    branchRemainedDaysToExpirePointToNotifyCustomer = json['branchRemainedDaysToExpirePointToNotifyCustomer'];
    defaultRemainedDaysToExpirePointToNotifyCustomer = json['defaultRemainedDaysToExpirePointToNotifyCustomer'];
    branchMaxExpiringPointToNotifyCustomer = json['branchMaxExpiringPointToNotifyCustomer'];
    defaultMaxExpiringPointToNotifyCustomer = json['defaultMaxExpiringPointToNotifyCustomer'];
  }
}
