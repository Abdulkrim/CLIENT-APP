import 'package:equatable/equatable.dart';
import 'package:merchant_dashboard/feature/products/data/models/entity/dependency_item.dart';
import 'package:merchant_dashboard/feature/products/data/models/entity/item_type.dart';

import '../../../../../core/localazation/service/localization_service/localization_service.dart';
import '../../../../../injection.dart';
import 'offer_type.dart';
import 'product_stock.dart';

class ProductsCategory extends Equatable {
  int categoryId;
  String categoryNameEN;
  String categoryNameAR;
  String categoryNameTR;
  String categoryNameFR;
  final List<String> visibleApplications;

  bool isActive;
  List<SubCategory>? subCategories;

  String imageUrl;

  ProductsCategory({
    required this.categoryId,
    required this.categoryNameEN,
    required this.categoryNameFR,
    required this.categoryNameTR,
    required this.categoryNameAR,
    required this.visibleApplications,
    required this.isActive,
    required this.imageUrl,
    required this.subCategories,
  });

  String get categoryName => getIt<LocalizationService>().getLanguage() == 'tr'
      ? categoryNameTR
      : getIt<LocalizationService>().getLanguage() == 'ar'
          ? categoryNameAR
          : categoryNameEN;

  update({
    String nameEn = '',
    String nameAr = '',
    String nameTr = '',
    String nameFr = '',
    String imageUrl = '',
    bool changedActive = true,
    List<SubCategory> subCats = const [],
  }) {
    categoryNameEN = nameEn;
    categoryNameFR = nameFr;
    categoryNameTR = nameTr;
    categoryNameAR = nameAr;
    isActive = changedActive;
    subCategories = subCats;
  }

  @override
  List<Object?> get props => [
        categoryId,
        categoryNameEN,
        categoryNameAR,
        categoryNameTR,
        categoryNameFR,
        isActive,
        subCategories,
        imageUrl,
      ];
}

class SubCategory extends Equatable {
  int subCategoryId;
  int categoryId;
  String categoryNameEN;
  String categoryNameAR;
  String categoryNameTR;
  String categoryNameFR;
  final List<String> visibleApplications;
  String imageUrl;
  bool isActive;
  List<Product> products;

  String get subCategoryName => getIt<LocalizationService>().getLanguage() == 'tr'
      ? categoryNameTR
      : getIt<LocalizationService>().getLanguage() == 'ar'
          ? categoryNameAR
          : categoryNameEN;

  SubCategory({
    required this.subCategoryId,
    required this.categoryId,
    required this.categoryNameEN,
    required this.categoryNameFR,
    required this.categoryNameTR,
    required this.categoryNameAR,
    required this.imageUrl,
    required this.isActive,
    required this.visibleApplications,
    required this.products,
  });

  update({
    String nameEn = '',
    String nameAr = '',
    String nameTr = '',
    String nameFr = '',
    String image = '',
    bool changeActive = true,
    List<Product> prods = const <Product>[],
  }) {
    categoryNameEN = nameEn;
    categoryNameFR = nameFr;
    categoryNameTR = nameTr;
    categoryNameAR = nameAr;
    isActive = changeActive;
    products = prods;
    imageUrl = image.isEmpty ? imageUrl : image;
  }

  @override
  List<Object?> get props => [
        subCategoryId,
        categoryId,
        categoryNameEN,
        categoryNameAR,
        categoryNameTR,
        categoryNameFR,
        imageUrl,
        isActive,
        products,
      ];
}

class Product extends Equatable {
  final int productId;
  final int categoryId;
  final int subCategoryId;
  final String productNameEN;
  final String productNameFR;
  final String productNameTR;
  final String productNameAR;

  String get productName => getIt<LocalizationService>().getLanguage() == 'tr'
      ? productNameTR
      : getIt<LocalizationService>().getLanguage() == 'ar'
          ? productNameAR
          : productNameEN;

  final String currency;
  final num quantity;
  final num discount;

  final num _originalPrice;

  num get originalPrice => _originalPrice;

  String get managedPrice => '${isOpenPrice ? minPrice : _originalPrice} $currency';

  final num buyingPrice;
  final num maxPrice;
  final num minPrice;
  final ItemType? itemType;
  final OfferType? offerType;

  final String _logo;

  String get logo => _logo;
  final String description;
  final String barcodeNumber;
  final bool isActive;
  final bool isOpenQuantity;
  final bool isOpenPrice;
  final bool canHaveStock;
  final ProductStock? itemStock;
  final List<DependencyItem> addOnItems;
  final num redeemPoint;
  final num rechargePoint;
  final List<String> visibleApplications;

  const Product({
    required this.productId,
    required this.subCategoryId,
    required this.categoryId,
    required this.productNameEN,
    required this.productNameFR,
    required this.productNameTR,
    required this.productNameAR,
    required this.currency,
    required this.rechargePoint,
    required this.redeemPoint,
    this.itemType,
    required this.discount,
    required String logo,
    required this.quantity,
    required this.visibleApplications,
    required this.buyingPrice,
    required num price,
    required this.minPrice,
    required this.maxPrice,
    required this.description,
    required this.barcodeNumber,
    required this.isActive,
    required this.isOpenPrice,
    required this.isOpenQuantity,
    required this.offerType,
    required this.canHaveStock,
    required this.addOnItems,
    required this.itemStock,
  })  : _logo = logo,
        _originalPrice = price;

  @override
  List<Object?> get props => [
        productId,
        productNameEN,
        productNameFR,
        productNameTR,
        productNameAR,
        currency,
        redeemPoint,
        rechargePoint,
        itemType,
        quantity,
        managedPrice,
        buyingPrice,
        logo,
        addOnItems,
        maxPrice,
        minPrice,
        discount,
        isOpenQuantity,
        isOpenPrice,
        offerType,
        canHaveStock,
        itemStock,
        visibleApplications,
      ];
}

extension ConvertToDependency on Product {
  DependencyItem toDependencyItem() => DependencyItem(itemId: productId, relatedItemNameEn: productNameEN);
}
