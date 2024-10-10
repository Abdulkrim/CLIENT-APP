import 'feature_groups.dart';
import 'package_pricing_with_culture.dart';

class SubscriptionPlan {
  final int id;
  final String packageName;
  final PackagePricingWithCulture packagePricingWithCulture;
  final List<FeatureGroups> featureGroups;
  final List<String> includedPackages;
  String get includedPackageNames => includedPackages.length == 1 ? includedPackages.first : includedPackages.join(' and ');
  final String flag;
  final bool canBeTrial;

  SubscriptionPlan(
      {required this.id,
      required this.packageName,
      required this.includedPackages,
      required this.packagePricingWithCulture,
      required this.featureGroups,
      required this.flag,
      required this.canBeTrial});
}
