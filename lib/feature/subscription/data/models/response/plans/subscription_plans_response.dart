import 'package:json_annotation/json_annotation.dart';

import 'feature_groups_response.dart';
import 'package_pricing_response.dart';

part 'subscription_plans_response.g.dart';

@JsonSerializable()
class SubscriptionPlansResponse {
  int? id;
  String? packageName;
  PackagePricingWithCultureResponse? packagePricingWithCulture;
  List<FeatureGroupsResponse>? featureGroups;
  List<IncludedPackageResponse>? includedPackages;
  String? flag;
  bool? canBeTrial;

  SubscriptionPlansResponse(
      {this.id,
      this.packageName,
      this.packagePricingWithCulture,
      this.featureGroups,
      this.includedPackages,
      this.flag,
      this.canBeTrial});

  factory SubscriptionPlansResponse.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionPlansResponseFromJson(json);
}


class IncludedPackageResponse{
  int? id;
  String ? packageName;

  IncludedPackageResponse.fromJson(Map<String , dynamic> json) : id =json['id'] , packageName = json['packageName'];
  Map<String , dynamic> toJson()=>{};
}