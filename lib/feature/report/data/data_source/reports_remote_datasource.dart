import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/core/client/parameter/base_filter_parameter.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../core/utils/exceptions.dart';
import '../models/responese/cashier_reports_response.dart';
import '../models/responese/product_reports.dart';
import '../models/responese/sub_category_reports_response.dart';

abstract class IReportsRemoteDataSource {
  Future<CashierReportsResponse> getCashierReports(BaseFilterListParameter parameter);

  Future<String> getCashiersDownloadReports(BaseFilterListParameter parameter);

  Future<SubCategoryReportsResponse> getSubCategoriesReports(BaseFilterListParameter parameter);

  Future<String> getSubCategoriesDownloadReports(BaseFilterListParameter parameter);

  Future<ProductReportsResponse> getProductsReports(BaseFilterListParameter parameter);

  Future<String> getProductsDownloadReports(BaseFilterListParameter parameter);
}

@LazySingleton(as: IReportsRemoteDataSource)
class ReportsRemoteDataSource extends IReportsRemoteDataSource {
  final Dio _dioClient;

  ReportsRemoteDataSource(this._dioClient);

  @override
  Future<CashierReportsResponse> getCashierReports(BaseFilterListParameter parameter) async {
    try {
      final Response response =
          await _dioClient.post("Transaction/GetTransactionByCashier", data: parameter.filterToJson());

      if (response.statusCode == 200) {
        return CashierReportsResponse.fromJson(response.data);
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<String> getCashiersDownloadReports(BaseFilterListParameter parameter) async {
    try {
      final Response response =
          await _dioClient.post("Transaction/DownloadTransactionByCashier", data: parameter.filterToJson());

      if (response.statusCode == 200) {
        return response.data.toString();
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<ProductReportsResponse> getProductsReports(BaseFilterListParameter parameter) async {
    try {
      final Response response =
          await _dioClient.post("Transaction/GetTransactionByProduct", data: parameter.filterToJson());

      if (response.statusCode == 200) {
        return ProductReportsResponse.fromJson(response.data);
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<SubCategoryReportsResponse> getSubCategoriesReports(BaseFilterListParameter parameter) async {
    try {
      final Response response =
          await _dioClient.post("Transaction/GetTransactionBySubCategory", data: parameter.filterToJson());

      if (response.statusCode == 200) {
        return SubCategoryReportsResponse.fromJson(response.data);
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<String> getSubCategoriesDownloadReports(BaseFilterListParameter parameter) async {
    try {
      final Response response =
          await _dioClient.post("Transaction/DownloadTransactionBySubCategory", data: parameter.filterToJson());

      if (response.statusCode == 200) {
        return response.data.toString();
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<String> getProductsDownloadReports(BaseFilterListParameter parameter) async {
    try {
      final Response response =
          await _dioClient.post("Transaction/DownloadTransactionByProduct", data: parameter.filterToJson());

      if (response.statusCode == 200) {
        return response.data.toString();
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }
}
