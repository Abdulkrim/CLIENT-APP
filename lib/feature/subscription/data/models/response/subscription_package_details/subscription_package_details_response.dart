import '../../entity/subscription_package_details.dart';
import 'subscription_package_details_item_response.dart';

class SubscriptionPackageDetailsResponse {
  List<SubscriptionPackageDetailsItemResponse> items;

  SubscriptionPackageDetailsResponse(this.items);

  SubscriptionPackageDetailsResponse.fromJson(List<dynamic>? json)
      : items = json?.map((e) => SubscriptionPackageDetailsItemResponse.fromJson(e)).toList() ?? [];

  List<SubscriptionPackageDetails> toEntity() => items
      .map((e) => SubscriptionPackageDetails(
          isInTheSelectedPackage: e.isInTheSelectedPackage ?? false,
          totalPrice: e.totalPrice ?? 0,
          featuresWithCulture: e.featuresWithCulture?.map((e) => e.toEntity()).toList() ?? [],
          id: e.id ?? 0,
          featureGroupName: e.featureGroupName ?? ''))
      .toList();
}
