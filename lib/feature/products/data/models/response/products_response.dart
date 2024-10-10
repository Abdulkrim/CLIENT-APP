import '../entity/products.dart';
import 'product_item_response.dart';

class ProductsResponse {
  List<_ValueResponse>? value;
  int? currentPageNumber;
  int? totalPageCount;
  int? totalAmount;

  ProductsResponse.fromJson(Map<String, dynamic> json) {
    value = <_ValueResponse>[];

    if((json['value'] as List<dynamic>).isEmpty){
      value = [];

    }else{
      if (json['value'][0]['setting'] == null) {
        value = [
          _ValueResponse(
              null,
              (json['value'] as List<dynamic>)
                  .map(
                    (e) => ProductItemResponse.fromJson(e),
                  )
                  .toList())
        ];
      } else {
        json['value'].forEach((v) {
          value!.add(_ValueResponse.fromJson(v));
        });
      }
    }



    currentPageNumber = json['currentPageNumber'];
    totalPageCount = json['totalPageCount'];
    totalAmount = json['totalAmount'];
  }

  Map<String, dynamic> toJson() => {};

  List<Product> toEntity() => value!.first.items.map((e) => e.toEntity()).toList();
}

class _ValueResponse {
  bool? isLoyaltyAllowed;
  List<ProductItemResponse> items;

  _ValueResponse(this.isLoyaltyAllowed, this.items);

  _ValueResponse.fromJson(Map<String, dynamic>? json)
      : isLoyaltyAllowed = json?['setting']?['loyaltyAllowed'],
        items = (json?['items'] as List<dynamic>).map((e) => ProductItemResponse.fromJson(e)).toList();
}
