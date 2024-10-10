import '../../entity/shared_feature.dart';

class SharedFeaturesResponse {
  List<SharedFeatureItemResponse> features;

  SharedFeaturesResponse(this.features);

  SharedFeaturesResponse.fromJson(List<dynamic>? json)
      : features = json?.map((e) => SharedFeatureItemResponse.fromJson(e)).toList() ?? [];

  List<SharedFeature> toEntity() => features
      .map((e) => SharedFeature(
          id: e.id ?? 0,
          featureNameWithCulture: e.featureNameWithCulture ?? '',
          featureGroupId: e.featureGroupId ?? 0,
          iconUrl: e.iconUrl ?? ''))
      .toList();
}

class SharedFeatureItemResponse {
  int? id;
  String? featureNameWithCulture;
  int? featureGroupId;
  String? iconUrl;

  SharedFeatureItemResponse({
    this.id,
    this.featureNameWithCulture,
    this.featureGroupId,
    this.iconUrl,
  });

  SharedFeatureItemResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    featureNameWithCulture = json['featureNameWithCulture'];
    featureGroupId = json['featureGroupId'];
    iconUrl = json['iconUrl'];
  }
}
