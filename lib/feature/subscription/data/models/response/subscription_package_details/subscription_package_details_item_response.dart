import 'package:json_annotation/json_annotation.dart';

import 'feature_with_culture_response.dart';

part 'subscription_package_details_item_response.g.dart';

@JsonSerializable()
class SubscriptionPackageDetailsItemResponse {
  bool? isInTheSelectedPackage;
  num? totalPrice;
  List<FeatureWithCultureResponse>? featuresWithCulture;
  int? id;
  String? featureGroupName;

  SubscriptionPackageDetailsItemResponse(
      {this.isInTheSelectedPackage,
      this.totalPrice,
      this.featuresWithCulture,
      this.id,
      this.featureGroupName});

  factory SubscriptionPackageDetailsItemResponse.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionPackageDetailsItemResponseFromJson(json);
}
