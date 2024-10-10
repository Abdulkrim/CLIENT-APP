import 'package:either_dart/either.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/core/constants/defaults.dart';
import 'package:merchant_dashboard/core/utils/exceptions.dart';
import 'package:merchant_dashboard/core/utils/failure.dart';
import 'package:merchant_dashboard/feature/products/data/data_source/product_remote_datasource.dart';
import 'package:merchant_dashboard/feature/products/data/models/entity/item_type.dart';
import 'package:merchant_dashboard/feature/products/data/models/entity/measure_unit.dart';
import 'package:merchant_dashboard/feature/products/data/models/entity/offer_type.dart';
import 'package:merchant_dashboard/feature/products/data/models/entity/products.dart';
import 'package:merchant_dashboard/feature/products/data/models/entity/suggestion_item.dart';
import 'package:merchant_dashboard/feature/products/data/models/params/edit_product_parameter.dart';
import 'package:merchant_dashboard/feature/products/data/models/params/get_item_suggestions_parameter.dart';
import 'package:merchant_dashboard/feature/products/data/models/params/get_product_parameter.dart';
import 'package:merchant_dashboard/feature/products/data/models/params/get_products_by_type_parameter.dart';
import 'package:merchant_dashboard/feature/products/data/models/response/measure_unit/measure_unit_response.dart';
import 'package:merchant_dashboard/feature/products/data/models/response/product_category_response.dart';
import 'package:merchant_dashboard/feature/products/data/models/response/product_item_response.dart';

import '../../../../core/client/parameter/base_filter_parameter.dart';
import '../models/entity/suggestion_item_image.dart';
import '../models/params/add_product_parameter.dart';
import '../models/response/offers/offers_response.dart';

abstract class IProductRepository {
  Future<Either<Failure, ({List<Product> products, bool isLoyaltyAllowed})>> getSubCategoryProducts(
      {required String sortField, required int sortType, required int subCategoryId, required bool onlyActiveItems});

  Future<Either<Failure, List<OfferType>>> getOfferTypes();

  Future<Either<Failure, List<MeasureUnit>>> getMeasureUnits();

  Future<Either<Failure, List<ProductsCategory>>> searchProducts(
      {required String sortField, required int sortType, required String searchText, required bool onlyActiveItems});

  Future<Either<Failure, bool>> addProduct({required AddProductParameter parameter});

  Future<Either<Failure, bool>> deleteProduct({required int productId});

  Future<Either<Failure, bool>> editProduct({required EditProductParameter parameter});

  Future<Either<Failure, Product>> getSpecificProduct(String searchText);

  Future<Either<Failure, List<ItemType>>> getItemTypes();

  Future<Either<Failure, List<Product>>> getProductsByType({required int typeId});

  Future<Either<Failure, List<SuggestionItem>>> getItemsSuggestions({required String name});

  Future<Either<Failure, List<SuggestionItemImage>>> getItemsImageSuggestions({required int itemId});
}

@LazySingleton(as: IProductRepository)
class ProductRepository extends IProductRepository {
  final IProductRemoteDataSource _productRemoteDataSource;

  ProductRepository(this._productRemoteDataSource);

  @override
  Future<Either<Failure, List<OfferType>>> getOfferTypes() async {
    try {
      final OffersResponse response = await _productRemoteDataSource.getOffers();

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, List<MeasureUnit>>> getMeasureUnits() async {
    try {
      final MeasureUnitResponse response = await _productRemoteDataSource.getMeasureUnits();

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, ({List<Product> products, bool isLoyaltyAllowed})>> getSubCategoryProducts(
      {required String sortField, required int sortType, required int subCategoryId, required bool onlyActiveItems}) async {
    try {
      final response = await _productRemoteDataSource.getSubCategoryProducts(BaseFilterListParameter(filterInfo: [
        BaseFilterInfoParameter(
            logical: LogicalOperator.and.value,
            operator: QueryOperator.equals.value,
            propertyName: 'subCategoryId',
            value: subCategoryId.toString()),
        if (onlyActiveItems)
          BaseFilterInfoParameter(
              logical: LogicalOperator.and.value,
              operator: QueryOperator.equals.value,
              propertyName: 'IsActive',
              value: onlyActiveItems.toString()),
      ], orderInfo: [
        BaseSortInfoParameter(orderType: sortType, property: 'price'),
      ]));

      return Right((products: response.toEntity(), isLoyaltyAllowed: response.value!.first.isLoyaltyAllowed ?? false));
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, List<ProductsCategory>>> searchProducts(
      {required String sortField, required int sortType, required String searchText, required bool onlyActiveItems}) async {
    try {
      final ProductCategoryResponse response = await _productRemoteDataSource.searchProducts(BaseFilterListParameter(filterInfo: [
        BaseFilterInfoParameter(
            logical: LogicalOperator.or.value,
            operator: QueryOperator.contains.value,
            propertyName: 'itemNameEN',
            value: searchText),
        BaseFilterInfoParameter(
            logical: LogicalOperator.or.value,
            operator: QueryOperator.contains.value,
            propertyName: 'itemNameFR',
            value: searchText),
        BaseFilterInfoParameter(
            logical: LogicalOperator.or.value,
            operator: QueryOperator.contains.value,
            propertyName: 'itemNameTR',
            value: searchText),
        BaseFilterInfoParameter(
            logical: LogicalOperator.or.value,
            operator: QueryOperator.contains.value,
            propertyName: 'itemNameAR',
            value: searchText),
        BaseFilterInfoParameter(
            logical: LogicalOperator.or.value,
            operator: QueryOperator.contains.value,
            propertyName: 'BarCode',
            value: searchText),
        if (onlyActiveItems)
          BaseFilterInfoParameter(
              logical: LogicalOperator.and.value,
              operator: QueryOperator.equals.value,
              propertyName: 'IsActive',
              value: onlyActiveItems.toString()),
      ], orderInfo: [
        BaseSortInfoParameter(orderType: sortType, property: 'price'),
      ]));

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, bool>> editProduct({required EditProductParameter parameter}) async {
    try {
      final bool response = await _productRemoteDataSource.editProduct(parameter);

      return Right(response);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, bool>> addProduct({required AddProductParameter parameter}) async {
    try {
      final bool response = await _productRemoteDataSource.addProduct(parameter);

      return Right(response);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, Product>> getSpecificProduct(String searchText) async {
    try {
      final ProductItemResponse response =
          await _productRemoteDataSource.getSpecificProduct(GetProductByBarcodeParameter(searchText: searchText));

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, List<ItemType>>> getItemTypes() async {
    try {
      final response = await _productRemoteDataSource.getItemTypes();

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getProductsByType({required int typeId}) async {
    try {
      final response =
          await _productRemoteDataSource.getProductsByType(GetProductsByTypeParameter(typeId: typeId, page: -1, count: 0));

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteProduct({required int productId}) async {
    try {
      final response = await _productRemoteDataSource.deleteProduct(productId);

      return Right(response);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, List<SuggestionItemImage>>> getItemsImageSuggestions({required int itemId}) async {
    try {
      final response = await _productRemoteDataSource.getItemsImageSuggestions(itemId);

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, List<SuggestionItem>>> getItemsSuggestions({required String name}) async {
    try {
      final response = await _productRemoteDataSource.getItemsSuggestions(GetItemSuggestionsParameter(name: name));

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }
}
