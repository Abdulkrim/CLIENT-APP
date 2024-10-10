import 'package:json_annotation/json_annotation.dart';

part 'item_details_response.g.dart';

@JsonSerializable()
class ItemDetailsResponse {
  int? itemId;
  String? itemNameEN;
  String? itemNameAR;
  String? itemNameTR;
  String? itemNameFR;
  String? subCategoryName;
  int? subCategoryId;
  int? itemTypeID;
  String? branchId;
  int? itemPlace;
  int? imageId;
  String? imageUrl;
  bool? isVisible;
  int? price;
  int? quantity;
  bool? isOpenPrice;
  bool? isOpenQuantity;
  num? maximumPrice;
  num? minimumPrice;
  num? buyingPrice;
  String? barCode;
  String? description;
  bool? isActive;
  int? subCategory;
  int? offerTypeId;
  String? offerTypeName;

  ItemDetailsResponse(
      {this.itemId,
        this.itemNameEN,
        this.itemNameAR,
        this.itemNameTR,
        this.itemNameFR,
        this.subCategoryName,
        this.subCategoryId,
        this.itemTypeID,
        this.branchId,
        this.itemPlace,
        this.imageId,
        this.imageUrl,
        this.isVisible,
        this.price,
        this.quantity,
        this.isOpenPrice,
        this.isOpenQuantity,
        this.maximumPrice,
        this.minimumPrice,
        this.buyingPrice,
        this.barCode,
        this.description,
        this.isActive,
        this.subCategory,
        this.offerTypeId,
        this.offerTypeName});

  factory ItemDetailsResponse.fromJson(Map<String, dynamic> json) => _$ItemDetailsResponseFromJson(json);
}
