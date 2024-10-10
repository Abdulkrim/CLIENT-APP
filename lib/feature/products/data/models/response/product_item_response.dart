import 'package:json_annotation/json_annotation.dart';
import 'package:merchant_dashboard/feature/products/data/models/entity/item_type.dart';
import 'package:merchant_dashboard/feature/products/data/models/entity/measure_unit.dart';
import 'package:merchant_dashboard/feature/products/data/models/entity/product_stock.dart';
import 'package:merchant_dashboard/feature/products/data/models/response/addon/item_dependency_response.dart';

import '../../../../stock/data/models/response/item_stock_response.dart';
import '../entity/offer_type.dart';
import '../entity/products.dart';

part 'product_item_response.g.dart';

@JsonSerializable()
class ProductItemResponse {
  @JsonKey(name: 'itemId')
  final num? productId;
  final num? subCategoryId;
  final num? categoryId;
  final String? itemNameEN;
  final String? itemNameAR;
  final String? itemNameTR;
  final String? itemNameFR;
  final String? barCode;
  final num? quantity;
  final num? price;
  final num? buyingPrice;
  final num? maximumPrice;
  final num? minimumPrice;
  final num? discountAmount;
  final String? imageUrl;
  final String? description;
  final String? currency;
  final bool? isActive;
  final bool? canHaveStock;
  final bool? isOpenPrice;
  final bool? isOpenQuantity;
  final int? itemTypeID;
  final String? itemTypeName;
  final int? offerTypeId;
  final String? offerTypeName;
  final ItemStockResponse? itemStock;
  final List<ApplicationsResponse>? visibleApplications;
  final List<DependencyItemResponse>? itemDependencies;
  final num? redeemPoint;
  final num? rechargePoint;

  ProductItemResponse({
    this.productId,
    this.subCategoryId,
    this.categoryId,
    this.itemNameEN,
    this.imageUrl,
    this.itemNameAR,
    this.itemNameTR,
    this.itemNameFR,
    this.visibleApplications,
    this.quantity,
    this.description,
    this.price,
    this.buyingPrice,
    this.isActive,
    this.canHaveStock,
    this.isOpenQuantity,
    this.isOpenPrice,
    this.barCode,
    this.maximumPrice,
    this.minimumPrice,
    this.offerTypeId,
    this.offerTypeName,
    this.itemTypeID,
    this.itemTypeName,
    this.itemStock,
    this.currency,
    this.discountAmount,
    this.itemDependencies,
    this.rechargePoint,
    this.redeemPoint,
  });

  factory ProductItemResponse.fromJson(Map<String, dynamic> json) => _$ProductItemResponseFromJson(json);

  Product toEntity() => Product(
        productId: (productId ?? 0).toInt(),
        subCategoryId: (subCategoryId ?? 0).toInt(),
        categoryId: (categoryId ?? 0).toInt(),
        productNameAR: itemNameAR ?? '',
        productNameEN: itemNameEN ?? '',
        productNameFR: itemNameFR ?? '',
        productNameTR: itemNameTR ?? '',
        currency: currency ?? '',
        discount: discountAmount ?? 0,
        quantity: quantity ?? 0,
        isOpenPrice: isOpenPrice ?? false,
        isOpenQuantity: isOpenQuantity ?? false,
        minPrice: minimumPrice ?? 0,
        maxPrice: maximumPrice ?? 0,
        description: description ?? '',
        barcodeNumber: barCode ?? '',
        price: price ?? 0,
        buyingPrice: buyingPrice ?? 0,
        logo: imageUrl ?? '',
        isActive: isActive ?? false,
        redeemPoint: redeemPoint ?? 0,
        rechargePoint: rechargePoint ?? 0,
        addOnItems: itemDependencies?.map((e) => e.toEntity()).toList() ?? [],
        visibleApplications: visibleApplications?.map((e) => e.applicationName ?? '-').toList() ?? <String>[],
        itemStock: ProductStock(
            id: itemStock?.id ?? 0,
            quantity: itemStock?.quantity ?? 0,
            stockStatus: itemStock?.stockStatus ?? 0,
            measureUnit: itemStock == null
                ? null
                : MeasureUnit(
                    id: itemStock?.unitOfMeasure?.id ?? 0,
                    name: itemStock?.unitOfMeasure?.name ?? '',
                    symbol: itemStock?.unitOfMeasure?.symbol ?? '')),
        canHaveStock: canHaveStock ?? false,
        itemType: itemTypeID != null ? ItemType(id: itemTypeID ?? 0, name: itemTypeName ?? '') : null,
        offerType: offerTypeId != null ? OfferType(offerTypeId ?? 0, offerTypeName ?? '') : null,
      );
}

class ApplicationsResponse {
  String? applicationName;

  ApplicationsResponse.fromJson(Map<String, dynamic> json) : applicationName = json['applicationName'];

  Map<String, dynamic> toJson() => {};
}
