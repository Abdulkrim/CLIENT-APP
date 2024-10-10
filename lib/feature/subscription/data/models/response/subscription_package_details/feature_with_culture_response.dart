import 'package:json_annotation/json_annotation.dart';

import '../../entity/package_features_with_culture.dart';
import 'feature_price_with_culture_response.dart';

part 'feature_with_culture_response.g.dart';

@JsonSerializable()
class FeatureWithCultureResponse {
  bool? isInTheSelectedPackage;
  int? id;
  String? featureNameWithCulture;
  int? featureGroupId;
  FeaturePricingWithCultureResponse? featurePricingWithCulture;
  int? businessTypeId;
  String? iconUrl;
  bool? isDefault;

  FeatureWithCultureResponse(
      {this.isInTheSelectedPackage,
      this.id,
      this.featureNameWithCulture,
      this.featureGroupId,
      this.featurePricingWithCulture,
      this.businessTypeId,
      this.iconUrl,
      this.isDefault});

  factory FeatureWithCultureResponse.fromJson(Map<String, dynamic> json) =>
      _$FeatureWithCultureResponseFromJson(json);

  PackageFeaturesWithCulture toEntity() => PackageFeaturesWithCulture.packageDetails(
      id: id ?? 0,
      featureName: featureNameWithCulture ?? '',
      iconUrl: iconUrl ?? '',
      isInTheSelectedPackage: isInTheSelectedPackage,
      featureNameWithCulture: featureNameWithCulture,
      featureGroupId: featureGroupId,
      featurePricingWithCulture: featurePricingWithCulture?.toEntity(),
      isDefault: isDefault ?? false);
}
