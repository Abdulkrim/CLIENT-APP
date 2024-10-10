import 'package:merchant_dashboard/feature/manage_features/data/models/entity/user_plan_feature.dart';

class UserPlanFeatureResponse {
  List<PlanFeatureResponse> features;

  UserPlanFeatureResponse.fromJson(List<dynamic>? json)
      : features = json?.map((e) => PlanFeatureResponse.fromJson(e)).toList() ?? [];

  List<UserPlanFeature> toEntity() => features
      .map((e) =>
          UserPlanFeature(featureId: e.featureId ?? 0, defaultName: e.defaultName ?? '', fkey: e.key ?? ''))
      .toList();
}

class PlanFeatureResponse {
  int? featureId;
  String? defaultName;
  String? key;

  PlanFeatureResponse({this.featureId, this.defaultName, this.key});

  PlanFeatureResponse.fromJson(Map<String, dynamic> json) {
    featureId = json['featureId'];
    defaultName = json['defaultName'];
    key = json['key'];
  }
}
