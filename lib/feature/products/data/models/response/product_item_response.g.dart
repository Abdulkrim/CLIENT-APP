// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_item_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductItemResponse _$ProductItemResponseFromJson(Map<String, dynamic> json) =>
    ProductItemResponse(
      productId: json['itemId'] as num?,
      subCategoryId: json['subCategoryId'] as num?,
      categoryId: json['categoryId'] as num?,
      itemNameEN: json['itemNameEN'] as String?,
      imageUrl: json['imageUrl'] as String?,
      itemNameAR: json['itemNameAR'] as String?,
      itemNameTR: json['itemNameTR'] as String?,
      itemNameFR: json['itemNameFR'] as String?,
      visibleApplications: (json['visibleApplications'] as List<dynamic>?)
          ?.map((e) => ApplicationsResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      quantity: json['quantity'] as num?,
      description: json['description'] as String?,
      price: json['price'] as num?,
      buyingPrice: json['buyingPrice'] as num?,
      isActive: json['isActive'] as bool?,
      canHaveStock: json['canHaveStock'] as bool?,
      isOpenQuantity: json['isOpenQuantity'] as bool?,
      isOpenPrice: json['isOpenPrice'] as bool?,
      barCode: json['barCode'] as String?,
      maximumPrice: json['maximumPrice'] as num?,
      minimumPrice: json['minimumPrice'] as num?,
      offerTypeId: (json['offerTypeId'] as num?)?.toInt(),
      offerTypeName: json['offerTypeName'] as String?,
      itemTypeID: (json['itemTypeID'] as num?)?.toInt(),
      itemTypeName: json['itemTypeName'] as String?,
      itemStock: json['itemStock'] == null
          ? null
          : ItemStockResponse.fromJson(
              json['itemStock'] as Map<String, dynamic>),
      currency: json['currency'] as String?,
      discountAmount: json['discountAmount'] as num?,
      itemDependencies: (json['itemDependencies'] as List<dynamic>?)
          ?.map(
              (e) => DependencyItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      rechargePoint: json['rechargePoint'] as num?,
      redeemPoint: json['redeemPoint'] as num?,
    );

Map<String, dynamic> _$ProductItemResponseToJson(
        ProductItemResponse instance) =>
    <String, dynamic>{
      'itemId': instance.productId,
      'subCategoryId': instance.subCategoryId,
      'categoryId': instance.categoryId,
      'itemNameEN': instance.itemNameEN,
      'itemNameAR': instance.itemNameAR,
      'itemNameTR': instance.itemNameTR,
      'itemNameFR': instance.itemNameFR,
      'barCode': instance.barCode,
      'quantity': instance.quantity,
      'price': instance.price,
      'buyingPrice': instance.buyingPrice,
      'maximumPrice': instance.maximumPrice,
      'minimumPrice': instance.minimumPrice,
      'discountAmount': instance.discountAmount,
      'imageUrl': instance.imageUrl,
      'description': instance.description,
      'currency': instance.currency,
      'isActive': instance.isActive,
      'canHaveStock': instance.canHaveStock,
      'isOpenPrice': instance.isOpenPrice,
      'isOpenQuantity': instance.isOpenQuantity,
      'itemTypeID': instance.itemTypeID,
      'itemTypeName': instance.itemTypeName,
      'offerTypeId': instance.offerTypeId,
      'offerTypeName': instance.offerTypeName,
      'itemStock': instance.itemStock,
      'visibleApplications': instance.visibleApplications,
      'itemDependencies': instance.itemDependencies,
      'redeemPoint': instance.redeemPoint,
      'rechargePoint': instance.rechargePoint,
    };
