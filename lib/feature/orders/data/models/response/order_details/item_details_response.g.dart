// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemDetailsResponse _$ItemDetailsResponseFromJson(Map<String, dynamic> json) =>
    ItemDetailsResponse(
      itemId: (json['itemId'] as num?)?.toInt(),
      itemNameEN: json['itemNameEN'] as String?,
      itemNameAR: json['itemNameAR'] as String?,
      itemNameTR: json['itemNameTR'] as String?,
      itemNameFR: json['itemNameFR'] as String?,
      subCategoryName: json['subCategoryName'] as String?,
      subCategoryId: (json['subCategoryId'] as num?)?.toInt(),
      itemTypeID: (json['itemTypeID'] as num?)?.toInt(),
      branchId: json['branchId'] as String?,
      itemPlace: (json['itemPlace'] as num?)?.toInt(),
      imageId: (json['imageId'] as num?)?.toInt(),
      imageUrl: json['imageUrl'] as String?,
      isVisible: json['isVisible'] as bool?,
      price: (json['price'] as num?)?.toInt(),
      quantity: (json['quantity'] as num?)?.toInt(),
      isOpenPrice: json['isOpenPrice'] as bool?,
      isOpenQuantity: json['isOpenQuantity'] as bool?,
      maximumPrice: json['maximumPrice'] as num?,
      minimumPrice: json['minimumPrice'] as num?,
      buyingPrice: json['buyingPrice'] as num?,
      barCode: json['barCode'] as String?,
      description: json['description'] as String?,
      isActive: json['isActive'] as bool?,
      subCategory: (json['subCategory'] as num?)?.toInt(),
      offerTypeId: (json['offerTypeId'] as num?)?.toInt(),
      offerTypeName: json['offerTypeName'] as String?,
    );

Map<String, dynamic> _$ItemDetailsResponseToJson(
        ItemDetailsResponse instance) =>
    <String, dynamic>{
      'itemId': instance.itemId,
      'itemNameEN': instance.itemNameEN,
      'itemNameAR': instance.itemNameAR,
      'itemNameTR': instance.itemNameTR,
      'itemNameFR': instance.itemNameFR,
      'subCategoryName': instance.subCategoryName,
      'subCategoryId': instance.subCategoryId,
      'itemTypeID': instance.itemTypeID,
      'branchId': instance.branchId,
      'itemPlace': instance.itemPlace,
      'imageId': instance.imageId,
      'imageUrl': instance.imageUrl,
      'isVisible': instance.isVisible,
      'price': instance.price,
      'quantity': instance.quantity,
      'isOpenPrice': instance.isOpenPrice,
      'isOpenQuantity': instance.isOpenQuantity,
      'maximumPrice': instance.maximumPrice,
      'minimumPrice': instance.minimumPrice,
      'buyingPrice': instance.buyingPrice,
      'barCode': instance.barCode,
      'description': instance.description,
      'isActive': instance.isActive,
      'subCategory': instance.subCategory,
      'offerTypeId': instance.offerTypeId,
      'offerTypeName': instance.offerTypeName,
    };
