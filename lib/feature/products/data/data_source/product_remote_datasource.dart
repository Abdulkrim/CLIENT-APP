import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/core/utils/exceptions.dart';
import 'package:merchant_dashboard/feature/products/data/models/params/add_product_parameter.dart';
import 'package:merchant_dashboard/feature/products/data/models/params/edit_product_parameter.dart';
import 'package:merchant_dashboard/feature/products/data/models/params/get_item_suggestions_parameter.dart';
import 'package:merchant_dashboard/feature/products/data/models/params/get_product_parameter.dart';
import 'package:merchant_dashboard/feature/products/data/models/response/addon/item_types_response.dart';
import 'package:merchant_dashboard/feature/products/data/models/response/measure_unit/measure_unit_response.dart';
import 'package:merchant_dashboard/feature/products/data/models/response/product_item_response.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../core/client/parameter/base_filter_parameter.dart';
import '../../../../core/client/request_cancel_token.dart';
import '../models/params/get_products_by_type_parameter.dart';
import '../models/response/offers/offers_response.dart';
import '../models/response/product_category_response.dart';
import '../models/response/products_response.dart';
import '../models/response/suggestions/item_images_suggestions_response.dart';
import '../models/response/suggestions/item_suggestions_response.dart';

abstract class IProductRemoteDataSource {
  Future<ProductsResponse> getSubCategoryProducts(BaseFilterListParameter productsParameter);

  Future<bool> addProduct(AddProductParameter parameter);

  Future<bool> editProduct(EditProductParameter parameter);

  Future<bool> deleteProduct(int productId);

  Future<OffersResponse> getOffers();

  Future<MeasureUnitResponse> getMeasureUnits();

  Future<ProductItemResponse> getSpecificProduct(GetProductByBarcodeParameter parameter);

  Future<ProductCategoryResponse> searchProducts(BaseFilterListParameter productsParameter);

  Future<ItemTypesResponse> getItemTypes();

  Future<ProductsResponse> getProductsByType(GetProductsByTypeParameter parameter);

  Future<ItemSuggestionsResponse> getItemsSuggestions(GetItemSuggestionsParameter parameter);

  Future<ItemImagesSuggestionsResponse> getItemsImageSuggestions(int itemSuggestionId);
}

@LazySingleton(as: IProductRemoteDataSource)
class ProductRemoteDataSource extends IProductRemoteDataSource with RequestCancelToken {
  final Dio _dioClient;

  ProductRemoteDataSource(this._dioClient);

  @override
  Future<ProductCategoryResponse> searchProducts(BaseFilterListParameter productsParameter) async {
    try {
      final Response response = await _dioClient.post("Product/GetItemHierarchyList",
          data: productsParameter.filterToJson(), queryParameters: productsParameter.branchToJson());

      if (response.statusCode == 200) {
        final ProductCategoryResponse productsResponse = ProductCategoryResponse.fromJson(response.data);
        return productsResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<ProductsResponse> getSubCategoryProducts(BaseFilterListParameter productsParameter) async {
    try {
      final Response response = await _dioClient.post("Product/GetItemList",
          data: productsParameter.filterToJson(), queryParameters: productsParameter.branchToJson());

      if (response.statusCode == 200) {
        return ProductsResponse.fromJson(response.data);
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<bool> editProduct(EditProductParameter parameter) async {
    try {
      FormData formData = FormData.fromMap({
        if (parameter.logo != null)
          "File": MultipartFile.fromBytes(
            await parameter.logo!.readAsBytes(),
            filename: parameter.logo!.name,
            contentType: (parameter.logo!.platformMimeType != null)
                ? MediaType.parse(parameter.logo!.platformMimeType!)
                : MediaType('image', '*'),
          ),
        ...parameter.toJson()
      });

      final Response response = await _dioClient.patch("Product/Edit", data: formData);

      if (response.statusCode == 200) {
        return true;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<bool> addProduct(AddProductParameter parameter) async {
    try {
      FormData formData = FormData.fromMap({
        if (parameter.logo != null)
          "File": MultipartFile.fromBytes(
            await parameter.logo!.readAsBytes(),
            filename: parameter.logo!.name,
            contentType: (parameter.logo!.platformMimeType != null)
                ? MediaType.parse(parameter.logo!.platformMimeType!)
                : MediaType('image', '*'),
          ),
        ...parameter.toJson()
      });

      final Response response = await _dioClient.post("Product/Add", data: formData);

      if (response.statusCode == 200) {
        return true;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<OffersResponse> getOffers() async {
    try {
      final Response response = await _dioClient.get("Offer/GetOfferType");

      if (response.statusCode == 200) {
        final OffersResponse offersResponse = OffersResponse.fromJson(response.data);
        return offersResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<MeasureUnitResponse> getMeasureUnits() async {
    try {
      final Response response = await _dioClient.get("Stock/UnitOfMeasures");

      if (response.statusCode == 200) {
        final MeasureUnitResponse measureUnitResponse = MeasureUnitResponse.fromJson(response.data);
        return measureUnitResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<ProductItemResponse> getSpecificProduct(GetProductByBarcodeParameter parameter) async {
    try {
      final Response response = await _dioClient.get("Product/FindItem", queryParameters: parameter.byBarcodeToJson());

      if (response.statusCode == 200) {
        final ProductItemResponse productResponse = ProductItemResponse.fromJson(response.data);
        return productResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<ItemTypesResponse> getItemTypes() async {
    try {
      final Response response = await _dioClient.get("Product/GetItemTypes");

      if (response.statusCode == 200) {
        return ItemTypesResponse.fromJson(response.data);
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<ProductsResponse> getProductsByType(GetProductsByTypeParameter parameter) async {
    try {
      final Response response = await _dioClient.post("Product/GetItemNamesByType",
          queryParameters: parameter.itemsByTypeToJson(), data: parameter.filterToJson());

      if (response.statusCode == 200) {
        return ProductsResponse.fromJson(response.data);
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<bool> deleteProduct(int productId) async {
    try {
      final Response response = await _dioClient.delete("Product/Delete/$productId");

      if (response.statusCode == 200) {
        return true;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<ItemSuggestionsResponse> getItemsSuggestions(GetItemSuggestionsParameter parameter) async {
    try {
      final Response response = await _dioClient.get("Suggest/GetItems" , queryParameters: parameter.toJson());

      if (response.statusCode == 200) {
        return ItemSuggestionsResponse.fromJson(response.data);
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<ItemImagesSuggestionsResponse> getItemsImageSuggestions(int itemSuggestionId) async {
    try {
      final Response response = await _dioClient.get("Suggest/GetItemImages" , queryParameters:{'itemSuggestionId': itemSuggestionId});

      if (response.statusCode == 200) {
        return ItemImagesSuggestionsResponse.fromJson(response.data);
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }
}
