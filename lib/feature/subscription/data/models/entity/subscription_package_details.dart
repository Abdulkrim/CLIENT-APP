import 'package:merchant_dashboard/feature/subscription/data/models/entity/package_features_with_culture.dart';

class SubscriptionPackageDetails {
  final bool isInTheSelectedPackage;
  final num totalPrice;
  final List<PackageFeaturesWithCulture> featuresWithCulture;
  final int id;
  final String featureGroupName;

  SubscriptionPackageDetails(
      {required this.isInTheSelectedPackage,
      required this.totalPrice,
      required this.featuresWithCulture,
      required this.id,
      required this.featureGroupName});
}
