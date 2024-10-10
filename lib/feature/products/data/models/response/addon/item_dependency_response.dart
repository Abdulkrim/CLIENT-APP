import 'package:merchant_dashboard/feature/products/data/models/entity/dependency_item.dart';

class DependencyItemResponse {
  int? itemId;
  int? relatedItemId;
  String? relatedItemNameEn;
  String? relationName;

  DependencyItemResponse.fromJson(Map<String, dynamic> json)
      : itemId = json['itemId'],
        relatedItemId = json['relatedItemId'],
        relatedItemNameEn = json['relatedItemNameEn'],
        relationName = json['relationName'];


  Map<String , dynamic> toJson() => {};

  DependencyItem toEntity() => DependencyItem(itemId: relatedItemId ?? 0, relatedItemNameEn: relatedItemNameEn ?? '');
}
