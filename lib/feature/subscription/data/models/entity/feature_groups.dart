class FeatureGroups {
  final String featureGroup;
  final List<FeatureItem> features;
  final String iconUrl;

  FeatureGroups({required this.featureGroup, required this.features, required this.iconUrl});
}

class FeatureItem {
  final int id;
  final String featureGroupName;
  final String featureName;
  final String iconUrl;

  FeatureItem(
      {required this.id, required this.featureGroupName, required this.featureName, required this.iconUrl});
}
