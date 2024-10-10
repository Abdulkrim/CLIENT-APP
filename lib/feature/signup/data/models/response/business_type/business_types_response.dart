import '../../entity/business_type.dart';

class BusinessTypesResponse {
  final List<BusinessTypeItemResponse> items;

  BusinessTypesResponse(this.items);

  BusinessTypesResponse.fromJson(List<dynamic>? json)
      : items = json?.map((e) => BusinessTypeItemResponse.fromJson(e)).toList() ?? [];

  List<BusinessType> toEntity() =>
      items.map((e) => BusinessType(id: e.id ?? 0, name: e.name ?? '-', imageUrl: e.imageUrl ?? '')).toList();
}

class BusinessTypeItemResponse {
  int? id;
  String? name;
  String? imageUrl;

  BusinessTypeItemResponse({this.id, this.name, this.imageUrl});

  BusinessTypeItemResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['imageUrl'] = imageUrl;
    return data;
  }
}
