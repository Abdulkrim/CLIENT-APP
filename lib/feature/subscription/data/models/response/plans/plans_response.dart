import 'package:merchant_dashboard/feature/subscription/data/models/entity/feature_groups.dart';
import 'package:merchant_dashboard/feature/subscription/data/models/entity/subscription_plan.dart';

import 'subscription_plans_response.dart';

class PlansResponse {
  List<SubscriptionPlansResponse> plans;

  PlansResponse(this.plans);

  PlansResponse.fromJson(List<dynamic>? json)
      : plans = json?.map((e) => SubscriptionPlansResponse.fromJson(e)).toList() ?? [];

  List<SubscriptionPlan> toEntity() =>
      plans
          .map((e) =>
          SubscriptionPlan(
              id: e.id ?? 0,
              packageName: e.packageName ?? '',
              packagePricingWithCulture: e.packagePricingWithCulture!.toEntity(),
              featureGroups: e.featureGroups!
                  .map((e) =>
                  FeatureGroups(
                      featureGroup: e.featureGroup ?? '',
                      features: e.features
                          ?.map((f) =>
                          FeatureItem(
                              id: f.id ?? 0,
                              featureGroupName: f.featureGroupName ?? '',
                              featureName: f.featureName ?? '',
                              iconUrl: f.iconUrl ?? ''))
                          .toList() ??
                          [],
                      iconUrl: e.iconUrl ?? ''))
                  .toList(),
              flag: e.flag ?? '',
              includedPackages: e.includedPackages?.map((e) => e.packageName ?? '').toList() ?? [],
              canBeTrial: e.canBeTrial ?? false))
          .toList();
}
