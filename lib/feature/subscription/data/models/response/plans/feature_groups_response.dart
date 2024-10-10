import 'package:json_annotation/json_annotation.dart';


part 'feature_groups_response.g.dart';

@JsonSerializable()
class FeatureGroupsResponse {
  String? featureGroup;
  List<FeatureItemResponse>? features;
  String? iconUrl;

  FeatureGroupsResponse({this.featureGroup, this.features, this.iconUrl});

  factory FeatureGroupsResponse.fromJson(Map<String, dynamic> json) => _$FeatureGroupsResponseFromJson(json);
}

class FeatureItemResponse {
  int? id;
  String? featureGroupName;
  String? featureName;
  String? iconUrl;

  FeatureItemResponse({this.id, this.featureGroupName, this.featureName, this.iconUrl});

  FeatureItemResponse.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        featureGroupName = json['featureGroupName'],
        featureName = json['featureName'],
        iconUrl = json['iconUrl'] ?? '';

  Map<String, dynamic> toJson() => {};
}
