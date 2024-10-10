import '../../entity/suggestion_item.dart';

class ItemSuggestionsResponse {
  List<ItemSuggestionItemResponse> items;

  ItemSuggestionsResponse.fromJson(List<dynamic>? json)
      : items = json?.map((e) => ItemSuggestionItemResponse.fromJson(e)).toList() ?? [];

  List<SuggestionItem> toEntity() => items.map((e) => SuggestionItem(id: e.id ?? 0, name: e.name ?? '')).toList();
}

class ItemSuggestionItemResponse {
  int? id;
  String? name;

  ItemSuggestionItemResponse({this.id, this.name});

  ItemSuggestionItemResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
