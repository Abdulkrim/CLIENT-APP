import 'package:merchant_dashboard/feature/products/data/models/entity/suggestion_item_image.dart';

class ItemImagesSuggestionsResponse {
  List<ItemImagesSuggestionItemResponse> items;

  ItemImagesSuggestionsResponse.fromJson(List<dynamic>? json)
      : items = json?.map((e) => ItemImagesSuggestionItemResponse.fromJson(e)).toList() ?? [];

  List<SuggestionItemImage> toEntity() =>
      items.map((e) => SuggestionItemImage(id: e.id ?? 0, imageId: e.imageId ?? 0, imageUrl: e.imageURL ?? '')).toList();
}

class ItemImagesSuggestionItemResponse {
  int? id;
  int? imageId;
  String? imageURL;

  ItemImagesSuggestionItemResponse({this.id, this.imageId, this.imageURL});

  ItemImagesSuggestionItemResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageId = json['imageId'];
    imageURL = json['imageURL'];
  }
}
