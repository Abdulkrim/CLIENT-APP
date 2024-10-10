part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object?> get props => [];
}

class GetOfferTypes extends ProductsEvent {
  const GetOfferTypes();
}

class ChangeLanguageEvent extends ProductsEvent {
  const ChangeLanguageEvent();
}

class GetItemTypes extends ProductsEvent {
  const GetItemTypes();
}

class GetAddOnsProducts extends ProductsEvent {
  const GetAddOnsProducts();
}

class SearchProductsEvent extends ProductsEvent {
  final String searchText;
  final ProductSortTypes? sortType;
  final bool? onlyActiveItems;

  const SearchProductsEvent({required this.searchText, this.sortType, this.onlyActiveItems});

  @override
  List<Object?> get props => [searchText, sortType];
}

class GetProductsEvent extends ProductsEvent {
  final ProductSortTypes? sortType;
  final int? subCategoryId;
  final bool? onlyActiveItems;

  const GetProductsEvent({this.sortType, this.subCategoryId, this.onlyActiveItems});

  @override
  List<Object?> get props => [sortType];
}

class MainCategoryChangedEvent extends ProductsEvent {
  final ProductsCategory selectedCategory;

  const MainCategoryChangedEvent(this.selectedCategory);

  @override
  List<Object> get props => [selectedCategory];
}

class ClearProductSearchResultEvent extends ProductsEvent {
  const ClearProductSearchResultEvent();
}

class ChangeProductsShowTypeEvent extends ProductsEvent {
  const ChangeProductsShowTypeEvent();
}

class EditProductRequestEvent extends ProductsEvent {
  final int productId;
  final int offerTypeId;
  final String productEnName;
  final String description;
  final String productPrice;
  final String buyingPrice;
  final String discount;
  final String minPrice;
  final String maxPrice;
  final String barcode;
  final String productQuantity;
  final ItemType productType;
  final bool productIsActive;
  final bool isOpenPrice;
  final bool isOpenQuantity;
  final XFile? productImage;
  final int subCategory;
  final int lastSubCategoryId;
  final bool canHaveStock;
  final int unitOfMeasureId;
  final List<int> addOnIds;
  final String? redeemPoint;
  final String? rechargePoint;
  final int? suggestionImageId;
  final List<String>? hiddenApplications;

  const EditProductRequestEvent({
    required this.productId,
    required this.lastSubCategoryId,
    required this.offerTypeId,
    required this.productEnName,
    required this.description,
    required this.productPrice,
    required this.buyingPrice,
    required this.discount,
    required this.productQuantity,
    required this.productIsActive,
    required this.subCategory,
    required this.productType,
    required this.isOpenQuantity,
    required this.isOpenPrice,
    required this.maxPrice,
    required this.minPrice,
    required this.barcode,
    required this.canHaveStock,
    required this.unitOfMeasureId,
    required this.addOnIds,
    this.productImage,
    this.redeemPoint,
    this.rechargePoint,
    this.suggestionImageId,
    required this.hiddenApplications,
  });

  @override
  List<Object?> get props => [
        productId,
        offerTypeId,
        lastSubCategoryId,
        productEnName,
        suggestionImageId,
        description,
        redeemPoint,
        rechargePoint,
        productPrice,
        buyingPrice,
        discount,
        productQuantity,
        productIsActive,
        subCategory,
        productType,
        isOpenQuantity,
        isOpenPrice,
        maxPrice,
        minPrice,
        barcode,
        canHaveStock,
        unitOfMeasureId,
        addOnIds,
        hiddenApplications,
      ];
}

class DeleteProductRequestEvent extends ProductsEvent {
  final int productId;
  final int lastSubCategoryId;

  const DeleteProductRequestEvent({
    required this.productId,
    required this.lastSubCategoryId,
  });

  @override
  List<Object?> get props => [
        productId,
        lastSubCategoryId,
      ];
}

class AddProductRequestEvent extends ProductsEvent {
  final String productEnName;
  final String description;
  final List<int> addOnIds;
  final String productPrice;
  final String buyingPrice;
  final String minPrice;
  final String maxPrice;
  final String barcode;
  final String productQuantity;
  final String discount;
  final int? stockQuantity;
  final bool canHaveStock;
  final ItemType productType;
  final bool productIsActive;
  final bool isOpenPrice;
  final bool isOpenQuantity;
  final XFile? productImage;
  final int subCategory;
  final int offerTypeId;
  final int unitOfMeasureId;
  final String? redeemPoint;
  final String? rechargePoint;
  final int? suggestionImageId;
  final List<String>? hiddenApplications;

  const AddProductRequestEvent({
    required this.productEnName,
    required this.description,
    required this.productPrice,
    required this.buyingPrice,
    required this.discount,
    required this.productQuantity,
    required this.stockQuantity,
    required this.canHaveStock,
    required this.unitOfMeasureId,
    required this.productIsActive,
    required this.subCategory,
    required this.productType,
    required this.isOpenQuantity,
    required this.isOpenPrice,
    required this.maxPrice,
    required this.minPrice,
    required this.barcode,
    required this.offerTypeId,
    required this.addOnIds,
    this.productImage,
    this.redeemPoint,
    this.rechargePoint,
    this.suggestionImageId,
    required this.hiddenApplications,
  });

  @override
  List<Object?> get props => [
        productEnName,
        suggestionImageId,
        description,
        addOnIds,
        redeemPoint,
        rechargePoint,
        productPrice,
        buyingPrice,
        discount,
        productQuantity,
        productIsActive,
        subCategory,
        productType,
        isOpenQuantity,
        isOpenPrice,
        maxPrice,
        minPrice,
        barcode,
        offerTypeId,
        stockQuantity,
        canHaveStock,
        hiddenApplications,
        unitOfMeasureId,
      ];
}

class GetItemSuggestions extends ProductsEvent {
  final String name;

  const GetItemSuggestions(this.name);

  @override
  List<Object> get props => [name];
}

class GetItemSuggestionsImage extends ProductsEvent {
  final String suggestionItemName;

  const GetItemSuggestionsImage(this.suggestionItemName);

  @override
  List<Object> get props => [suggestionItemName];
}
