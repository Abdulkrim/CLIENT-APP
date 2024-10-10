class LoyaltySettings {
  final bool loyaltyAllowed;

  final num defaultRechargePointPerCurrency;
  final num branchRechargePointPerCurrency;

  final num defaultRemainedDaysToExpirePointToNotifyCustomer;
  final num branchRemainedDaysToExpirePointToNotifyCustomer;

  num get remainedDaysToExpirePoint =>
      branchRemainedDaysToExpirePointToNotifyCustomer > 0 ? branchRemainedDaysToExpirePointToNotifyCustomer : defaultRemainedDaysToExpirePointToNotifyCustomer;

  final num defaultMaxExpiringPointToNotifyCustomer;
  final num branchMaxExpiringPointToNotifyCustomer;

  num get maxExpiringPoint => branchMaxExpiringPointToNotifyCustomer > 0
      ? branchMaxExpiringPointToNotifyCustomer
      : defaultMaxExpiringPointToNotifyCustomer;

  num get rechargePoint => branchRechargePointPerCurrency > 0 ? branchRechargePointPerCurrency : defaultRechargePointPerCurrency;

  final num defaultRedeemPointPerCurrency;
  final num branchRedeemPointPerCurrency;

  num get redeemPoint => branchRedeemPointPerCurrency > 0 ? branchRedeemPointPerCurrency : defaultRedeemPointPerCurrency;

  final num defaultExpirePointDurationByDay;
  final num branchExpirePointDurationByDay;

  num get expireDuration => branchExpirePointDurationByDay > 0 ? branchExpirePointDurationByDay : defaultExpirePointDurationByDay;

  final num defaultMaxPercentOfPayByPoint;
  final num branchMaxPercentOfPayByPoint;

  num get maxPercentOfPoint => branchMaxPercentOfPayByPoint > 0 ? branchMaxPercentOfPayByPoint : defaultMaxPercentOfPayByPoint;

  final bool defaultIsSplitPaymentByPointsAllowed;
  final bool branchIsSplitPaymentByPointsAllowed;

  LoyaltySettings({
    required this.loyaltyAllowed,
    required this.defaultRechargePointPerCurrency,
    required this.branchRechargePointPerCurrency,
    required this.defaultRedeemPointPerCurrency,
    required this.branchRedeemPointPerCurrency,
    required this.defaultExpirePointDurationByDay,
    required this.branchExpirePointDurationByDay,
    required this.defaultMaxPercentOfPayByPoint,
    required this.branchMaxPercentOfPayByPoint,
    required this.defaultIsSplitPaymentByPointsAllowed,
    required this.branchIsSplitPaymentByPointsAllowed,
    required this.defaultRemainedDaysToExpirePointToNotifyCustomer,
    required this.branchRemainedDaysToExpirePointToNotifyCustomer,
    required this.defaultMaxExpiringPointToNotifyCustomer,
    required this.branchMaxExpiringPointToNotifyCustomer,
  });
}
