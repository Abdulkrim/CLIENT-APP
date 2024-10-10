import 'package:merchant_dashboard/feature/dashboard/data/models/params/merchant_branch_parameter.dart';

class ManageLoyaltySettingsParameter extends MerchantBranchParameter {
  final bool loyaltyAllowed;
  final bool isSplitAllowed;
  final num rechargePoint;
  final num redeemPoint;
  final num expireDuration;
  final num maxPercent;
  final num remainedDaysToExpirePointToNotifyCustomer;
  final num maxExpiringPointToNotifyCustomer;

  ManageLoyaltySettingsParameter(
      {super.branchId,
      required this.loyaltyAllowed,
      required this.isSplitAllowed,
      required this.rechargePoint,
      required this.redeemPoint,
      required this.expireDuration,
      required this.remainedDaysToExpirePointToNotifyCustomer,
      required this.maxExpiringPointToNotifyCustomer,
      required this.maxPercent});

  Map<String, dynamic> toJson() => {
        ...?super.branchToJson(),
        "loyaltyAllowed": loyaltyAllowed,
        "rechargePointPerCurrency": rechargePoint,
        "redeemPointPerCurrency": redeemPoint,
        "expirePointDurationByDay": expireDuration,
        "maxPercentOfPayByPoint": maxPercent,
        "isSplitPaymentByPointsAllowed": isSplitAllowed,
        "RemainedDaysToExpirePointToNotifyCustomer": remainedDaysToExpirePointToNotifyCustomer,
        "MaxExpiringPointToNotifyCustomer": maxExpiringPointToNotifyCustomer
      };
}
