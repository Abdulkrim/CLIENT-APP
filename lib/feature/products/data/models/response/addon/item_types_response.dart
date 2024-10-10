import '../../entity/item_type.dart';

class ItemTypesResponse {
  List<ItemTypeResponse> data;

  ItemTypesResponse.fromJson(List<dynamic>? json) : data = json?.map((e) => ItemTypeResponse.fromJson(e)).toList() ?? [];

  List<ItemType> toEntity() => data.map((e) => ItemType(id: e.itemId ?? 0, name: e.typeName ?? '')).toList();
}

class ItemTypeResponse {
  int? itemId;
  String? typeName;

  ItemTypeResponse.fromJson(Map<String, dynamic> json)
      : itemId = json['itemTypeID'],
        typeName = json['itemTypeName'];
}
