import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/core/client/parameter/base_filter_parameter.dart';
import 'package:merchant_dashboard/core/utils/exceptions.dart';
import 'package:merchant_dashboard/feature/products/data/models/params/add_main_category_parameter.dart';
import 'package:merchant_dashboard/feature/products/data/models/params/add_sub_category_parameter.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../models/response/product_category_response.dart';
import '../models/response/product_sub_category_response.dart';

abstract class ICategoryRemoteDataSource {
  Future<(int id, String image)> addMainCategory(AddMainCategoryParameter parameter);

  Future<(int id, String image)> addSubCategory(AddSubCategoryParameter parameter);

  Future<bool> deleteMainCategory({required int categoryId});

  Future<bool> deleteSubCategory({required int subCategoryId});

  Future<String> editMainCategory(AddMainCategoryParameter parameter);

  Future<String> editSubCategory(AddSubCategoryParameter parameter);

  Future<ProductCategoryResponse> getAllMainCategories(BaseFilterListParameter parameter);

  Future<ProductSubCategoryResponse> getAllSubCategories(BaseFilterListParameter parameter);
}

@LazySingleton(as: ICategoryRemoteDataSource)
class CategoryRemoteDataSource extends ICategoryRemoteDataSource {
  final Dio _dioClient;

  CategoryRemoteDataSource(this._dioClient);

  @override
  Future<(int id, String image)> addMainCategory(AddMainCategoryParameter parameter) async {
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

      final Response response = await _dioClient.post("/Category", data: formData);

      if (response.data['statusCode'] == 200) {
        return (int.parse(response.data['id'].toString()), response.data['imageUrl'].toString());
      }

      if (response.data case {'errors': List<dynamic> msgs}) {
        throw RequestException(msgs.first);
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      if (error.response?.data case {'errors': List<dynamic> msgs}) {
        throw RequestException(msgs.first);
      }
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<(int id, String image)> addSubCategory(AddSubCategoryParameter parameter) async {
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

      final Response response = await _dioClient.post("/SubCategory", data: formData);

      if (response.data['statusCode'] == 200) {
        return (int.parse(response.data['id'].toString()), response.data['imageUrl'].toString());
      }

      if (response.data case {'errors': List<dynamic> msgs}) {
        throw RequestException(msgs.first);
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      if (error.response?.data case {'errors': List<dynamic> msgs}) {
        throw RequestException(msgs.first);
      }
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<String> editSubCategory(AddSubCategoryParameter parameter) async {
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
      final Response response = await _dioClient.patch("/SubCategory", data: formData);

      if (response.data['statusCode'] == 200) {
        return response.data['imageUrl'] ?? '';
      }

      if (response.data case {'errors': List<dynamic> msgs}) {
        throw RequestException(msgs.first);
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      if (error.response?.data case {'errors': List<dynamic> msgs}) {
        throw RequestException(msgs.first);
      }
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<String> editMainCategory(AddMainCategoryParameter parameter) async {
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

      final Response response = await _dioClient.patch("/Category", data: formData);

      if (response.data['statusCode'] == 200) {
        return response.data['imageUrl'] ?? '';
      }

      if (response.data case {'errors': List<dynamic> msgs}) {
        throw RequestException(msgs.first);
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      if (error.response?.data case {'errors': List<dynamic> msgs}) {
        throw RequestException(msgs.first);
      }
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<ProductCategoryResponse> getAllMainCategories(BaseFilterListParameter parameter) async {
    try {
      final Response response = await _dioClient.post("Category/Get",
          data: parameter.filterToJson(), queryParameters: parameter.branchToJson());

      if (response.statusCode == 200) {
        final ProductCategoryResponse productsResponse = ProductCategoryResponse.fromJson(response.data);
        return productsResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<ProductSubCategoryResponse> getAllSubCategories(BaseFilterListParameter parameter) async {
    try {
      final Response response = await _dioClient.post("SubCategory/GetWithCategories",
          data: parameter.filterToJson(), queryParameters: parameter.branchToJson());

      if (response.statusCode == 200) {
        final ProductSubCategoryResponse productsResponse =
            ProductSubCategoryResponse.fromJson(response.data);
        return productsResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<bool> deleteMainCategory({required int categoryId})async {
    try {
      final Response response = await _dioClient.delete("Category/Delete", queryParameters: {'categoryId': categoryId});

      return response.statusCode == 200;
    } on DioException catch (error) {
      if(error.response?.statusCode! == 422 ){
        throw RequestException((error.response!.data['errors'] as List<dynamic>).first);      }
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<bool> deleteSubCategory({required int subCategoryId}) async {
    try {
      final Response response = await _dioClient.delete("SubCategory/Delete", queryParameters: {'subcategoryId': subCategoryId});

      return response.statusCode == 200;
    } on DioException catch (error) {
      if(error.response?.statusCode! == 422 ){
        throw RequestException((error.response!.data['errors'] as List<dynamic>).first);
      }
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }
}
