import 'package:merchant_dashboard/feature/subscription/data/models/entity/currency_info.dart';

class BranchPlanDetails {
  final String id;
  final String branchId;
  final bool isOnTrial;
  final num packagePrice;
  final num taxPrice;
  final num extraFeaturesPrice;
  final num finalPrice;
  final bool isActive;
  final String expirationDate;
  final String subscriptionDate;
  final int daysRemaining;
  final CurrencyInfo currency;
  final String packageName;

  BranchPlanDetails(
      {required this.id,
      required this.branchId,
      required this.isOnTrial,
      required this.packagePrice,
      required this.taxPrice,
      required this.extraFeaturesPrice,
      required this.finalPrice,
      required this.isActive,
      required this.expirationDate,
      required this.subscriptionDate,
      required this.daysRemaining,
      required this.currency,
      required this.packageName});
}
