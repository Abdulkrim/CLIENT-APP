import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/core/constants/defaults.dart';
import 'package:merchant_dashboard/core/utils/failure.dart';
import 'package:merchant_dashboard/feature/main_screen/presentation/blocs/main_screen_bloc.dart';
import 'package:merchant_dashboard/feature/products/data/models/entity/item_type.dart';
import 'package:merchant_dashboard/feature/products/data/models/entity/measure_unit.dart';
import 'package:merchant_dashboard/feature/products/data/models/entity/product_sort_types.dart';
import 'package:merchant_dashboard/feature/products/data/models/entity/products.dart';
import 'package:merchant_dashboard/feature/products/data/models/entity/suggestion_item.dart';
import 'package:merchant_dashboard/feature/products/data/models/entity/suggestion_item_image.dart';
import 'package:merchant_dashboard/feature/products/data/repository/product_repository.dart';
import 'package:merchant_dashboard/injection.dart';
import 'package:get/get.dart';

import '../../../../../core/bloc_base_state/base_bloc.dart';
import '../../../data/models/entity/offer_type.dart';
import '../../../data/models/params/add_product_parameter.dart';
import '../../../data/models/params/edit_product_parameter.dart';

part 'products_event.dart';

part 'products_state.dart';

@injectable
class ProductsBloc extends BaseBloc<ProductsEvent, ProductsState> {
  bool isListView = false;
  bool isSearchMode = false;

  final List<ProductSortTypes> sortTypes = [
    ProductSortTypes('Price : High to Low', Defaults.sortFiledPrice, OrderOperator.desc.value),
    ProductSortTypes('Price : Low to High', Defaults.sortFiledPrice, OrderOperator.asc.value),
  ];
  late ProductSortTypes selectedSortType = sortTypes.first;

  String searchText = '';

  List<MeasureUnit> measureUnits = getIt<MainScreenBloc>().measureUnits;

  List<ItemType> itemTypes = [];
  List<OfferType> offerTypes = [];
  List<Product> products = [];
  bool isLoyaltyAllowed = false;
  List<Product> addOnProducts = [];

  List<ProductsCategory> searchResult = [];

  ProductsCategory? selectedMainCategory;
  int? selectedSubCategoryId;

  bool onlyActiveItems = false;

  final IProductRepository _iProductRepository;
  final searchController = TextEditingController();

  List<SuggestionItem> suggestionItems = [];
  List<SuggestionItemImage> suggestionItemImages = [];

  ProductsBloc(this._iProductRepository) : super(ProductsInitial()) {
    getIt<MainScreenBloc>().stream.listen((state) {
      if (state is MerchantInfoSelectionChangedState && state.merchantInfo.hasData) {}
      if (state is GetMeasureUnitsSuccess) {
        measureUnits = state.measureUnits;
      }
    });

    on<ChangeLanguageEvent>((event, emit) {
      emit(const GetProductsState(isSuccess: true));
    });

    on<GetOfferTypes>((event, emit) async {
      final Either<Failure, List<OfferType>> offerResult = await _iProductRepository.getOfferTypes();

      offerResult.fold((left) {
        debugPrint('offer error: ${left.errorMessage}');
      }, (right) {
        offerTypes = right;
        emit(const GetOffersSuccessState());
      });
    });

    on<GetItemTypes>((event, emit) async {
      final itemTypesResult = await _iProductRepository.getItemTypes();

      itemTypesResult.fold((left) {
        debugPrint('offer error: ${left.errorMessage}');
      }, (right) {
        itemTypes = right;

        add(const GetAddOnsProducts());
      });
    });

    on<GetAddOnsProducts>((event, emit) async {
      emit(const GetAddOnsStates(isLoading: true));
      final itemTypesResult = await _iProductRepository.getProductsByType(typeId: itemTypes.addOnItemTypeId);

      itemTypesResult.fold((left) {
        emit(GetAddOnsStates(errorMsg: left.errorMessage));
      }, (right) {
        addOnProducts = right;
        emit(const GetAddOnsStates(isSuccess: true));
      });
    });

    on<GetProductsEvent>((event, emit) async {
      isSearchMode = false;
      selectedSortType = event.sortType ?? sortTypes.first;

      if (event.onlyActiveItems != null) onlyActiveItems = event.onlyActiveItems!;

      if (event.subCategoryId != null) selectedSubCategoryId = event.subCategoryId;

      if (selectedSubCategoryId != null) {
        products = [];
        emit(const GetProductsState(isLoading: true));
        Either<Failure, ({bool isLoyaltyAllowed, List<Product> products})> productsResult =
            await _iProductRepository.getSubCategoryProducts(
                onlyActiveItems: onlyActiveItems,
                sortField: selectedSortType.sortField,
                sortType: selectedSortType.sortType,
                subCategoryId: selectedSubCategoryId!);

        productsResult.fold((left) {
          debugPrint('Products error: ${left.errorMessage}');
          emit(GetProductsState(errorMsg: left.errorMessage));
        }, (right) {
          if (right.products.isNotEmpty) {
            isLoyaltyAllowed = right.isLoyaltyAllowed;
            products = right.products;
            emit(const GetProductsState(isSuccess: true));
          } else {
            products.clear();
            emit(const GetProductsState(isEmpty: true));
          }
        });
      }
    });

    on<SearchProductsEvent>((event, emit) async {
      selectedMainCategory = null;
      selectedSubCategoryId = null;

      if (event.onlyActiveItems != null) onlyActiveItems = event.onlyActiveItems!;

      isSearchMode = true;

      searchText = event.searchText;
      selectedSortType = event.sortType ?? sortTypes.first;
      if (searchText.trim().isNotEmpty) {
        emit(const SearchProductsState(isLoading: true));

        Either<Failure, List<ProductsCategory>> productsResult = await _iProductRepository.searchProducts(
            sortField: selectedSortType.sortField,
            sortType: selectedSortType.sortType,
            searchText: searchText,
            onlyActiveItems: onlyActiveItems);

        productsResult.fold((left) {
          emit(SearchProductsState(errorMsg: left.errorMessage));
        }, (right) {
          if (right.isNotEmpty) {
            searchResult = right;
            emit(const SearchProductsState(isSuccess: true));
          } else {
            searchResult.clear();
            emit(const SearchProductsState(isEmpty: true));
          }
        });
      } else {
        add(const GetProductsEvent(subCategoryId: null));
      }
    });

    on<ClearProductSearchResultEvent>((event, emit) {
      searchResult = [];
      isSearchMode = false;
      searchController.clear();
      emit(const ClearProductSearchResultState());
    });

    on<MainCategoryChangedEvent>((event, emit) async {
      selectedMainCategory = event.selectedCategory;
      products = [];
      // emit(ProductMainCategoryChangedState());
    });

    on<ChangeProductsShowTypeEvent>((event, emit) async {
      isListView = !isListView;
      emit(UpdateIsListViewState(isListView));
    });

    on<AddProductRequestEvent>((event, emit) async {
      emit(const EditProductStates(isLoading: true));
      Either<Failure, bool> result = await _iProductRepository.addProduct(
          parameter: AddProductParameter(
        subCategoryId: event.subCategory,
        productEnName: event.productEnName,
        productPrice: event.productPrice,
        buyingPrice: event.buyingPrice,
        productQuantity: event.productQuantity,
        productIsActive: event.productIsActive,
        logo: event.productImage,
        productType: event.productType,
        barcode: event.barcode,
        minPrice: event.minPrice,
        maxPrice: event.maxPrice,
        isOpenPrice: event.isOpenPrice,
        isOpenQuantity: event.isOpenQuantity,
        description: event.description,
        offerTypeId: event.offerTypeId,
        canHaveStock: event.canHaveStock,
        initialQuantity: event.stockQuantity,
        unitOfMeasureId: event.unitOfMeasureId,
        redeemPoint: event.redeemPoint,
        rechargePoint: event.rechargePoint,
        discount: event.discount,
        addOnsItemIds: event.addOnIds,
        visibleApplications: event.hiddenApplications,
        suggestionImageId: event.suggestionImageId,
      ));

      result.fold((left) {
        debugPrint("edit product has error: ${left.errorMessage}");
        emit(EditProductStates(errorMsg: left.errorMessage));
      }, (right) {
        emit(const EditProductStates(msg: "Product added successfully!"));

        selectedSubCategoryId = null;
        add(GetProductsEvent(subCategoryId: event.subCategory));

        add(const GetAddOnsProducts());
      });
    });

    on<EditProductRequestEvent>((event, emit) async {
      emit(const EditProductStates(isLoading: true));

      Either<Failure, bool> result = await _iProductRepository.editProduct(
          parameter: EditProductParameter(
        itemId: event.productId,
        subCategoryId: event.subCategory,
        productEnName: event.productEnName,
        productPrice: event.productPrice,
        buyingPrice: event.buyingPrice,
        productQuantity: event.productQuantity,
        productIsActive: event.productIsActive,
        logo: event.productImage,
        productType: event.productType,
        barcode: event.barcode,
        minPrice: event.minPrice,
        maxPrice: event.maxPrice,
        isOpenPrice: event.isOpenPrice,
        isOpenQuantity: event.isOpenQuantity,
        description: event.description,
        offerTypeId: event.offerTypeId,
        canHaveStock: event.canHaveStock,
        unitOfMeasureId: event.unitOfMeasureId,
        redeemPoint: event.redeemPoint,
        rechargePoint: event.rechargePoint,
        discount: event.discount,
        hiddenApplications: event.hiddenApplications,
        addOnsItemIds: event.addOnIds,
        suggestionImageId: event.suggestionImageId,
      ));

      result.fold((left) {
        debugPrint("edit product has error: ${left.errorMessage}");

        emit(EditProductStates(errorMsg: left.errorMessage));
      }, (right) {
        emit(const EditProductStates(msg: "Product Edited successfully!"));

        add(GetProductsEvent(subCategoryId: event.lastSubCategoryId));

        if (searchController.text.isNotEmpty) add(const ClearProductSearchResultEvent());

        add(const GetAddOnsProducts());
      });
    });

    on<DeleteProductRequestEvent>((event, emit) async {
      emit(const EditProductStates(isLoading: true));

      Either<Failure, bool> result = await _iProductRepository.deleteProduct(productId: event.productId);

      result.fold((left) {
        debugPrint("edit product has error: ${left.errorMessage}");

        emit(EditProductStates(errorMsg: left.errorMessage));
      }, (right) {
        emit(const EditProductStates(msg: "Product Deleted successfully!"));

        add(GetProductsEvent(subCategoryId: event.lastSubCategoryId));

        if (searchController.text.isNotEmpty) add(const ClearProductSearchResultEvent());

        add(const GetAddOnsProducts());
      });
    });

    on<GetItemSuggestions>((event, emit) async {
      emit(const GetItemSuggestionStates(isLoading: true));

      final result = await _iProductRepository.getItemsSuggestions(name: event.name);

      result.fold((left) {
        emit(GetItemSuggestionStates(errorMsg: left.errorMessage));
      }, (right) {
        suggestionItems = right;
        emit(const GetItemSuggestionStates(isSuccess: true));
      });
    });

    on<GetItemSuggestionsImage>((event, emit) async {
      final suggestionItem = suggestionItems.firstWhereOrNull(
          (element) => element.name.toLowerCase() == event.suggestionItemName.toLowerCase());
      if (suggestionItem != null) {
        // emit(const GetItemSuggestionsImageStates(isLoading: true));

        final result = await _iProductRepository.getItemsImageSuggestions(itemId: suggestionItem.id);

        result.fold((left) {
          // emit(GetItemSuggestionsImageStates(errorMsg: left.errorMessage));
        }, (right) {
          suggestionItemImages = right;
          // emit(const GetItemSuggestionsImageStates(isSuccess: true));
        });
      }
    });
  }

  Future<List<String>> getSuggestionItems(String name) async {
    final result = await _iProductRepository.getItemsSuggestions(name: name);
    if (result.isRight) {
      suggestionItems = result.right;
      return suggestionItems.map((e) => e.name).toList();
    }

    return <String>[];
  }

  Future<List<SuggestionItemImage>> getSuggestionItemsImage(String name) async {
    final suggestionItem = suggestionItems.firstWhereOrNull(
            (element) => element.name.toLowerCase() == name.toLowerCase());

    if (suggestionItem == null) return[];
    final result = await _iProductRepository.getItemsImageSuggestions(itemId: suggestionItem!.id);
    if (result.isRight) {
      suggestionItemImages = result.right;
      return suggestionItemImages;
    }

    return <SuggestionItemImage>[];
  }

  manageLastSearch() {
    if (searchText.isNotEmpty) {
      searchText = '';
    }
  }
}
