import 'package:merchant_dashboard/feature/subscription/data/models/entity/package_pricing_with_culture.dart';

class PackageFeaturesWithCulture {
  final int id;
  final String featureName;
  final String iconUrl;

  String? featureGroupName;
  bool? isInTheSelectedPackage;
  String? featureNameWithCulture;
  int? featureGroupId;
  PackagePricingWithCulture? featurePricingWithCulture;

  bool? _isDefault;

  bool get isSubFeatureSelected => (_isDefault ?? false);

  PackageFeaturesWithCulture.basic({required this.id, required this.featureName, required this.iconUrl});

  PackageFeaturesWithCulture.packageDetails({
    required this.id,
    required this.featureName,
    required this.iconUrl,
    required this.isInTheSelectedPackage,
    required this.featureNameWithCulture,
    required this.featureGroupId,
    required this.featurePricingWithCulture,
    required bool isDefault,
  }) : _isDefault = isDefault;
}
