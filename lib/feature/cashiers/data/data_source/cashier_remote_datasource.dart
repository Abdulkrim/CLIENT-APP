import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/core/utils/exceptions.dart';
import 'package:merchant_dashboard/feature/cashiers/data/models/params/add_cashier_parameter.dart';
import 'package:merchant_dashboard/feature/cashiers/data/models/params/delete_cashier_parameter.dart';
import 'package:merchant_dashboard/feature/cashiers/data/models/params/edit_cashier_parameter.dart';
import 'package:merchant_dashboard/feature/cashiers/data/models/response/cashier_roles_response.dart';
import 'package:merchant_dashboard/feature/cashiers/data/models/response/cashiers_response.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../core/client/parameter/base_filter_parameter.dart';
import '../../../../core/client/request_cancel_token.dart';
import '../models/params/get_cashiers_parameter.dart';
import '../models/response/cashier_summerized_response.dart';

abstract class ICashierRemoteDataSource {
  Future<CashierSummerizedResponse> getAllCashiersOnce(GetCashiersParameter parameter);

  Future<CashiersResponse> getAllCashiers(BaseFilterListParameter filterBodyParameter);

  Future<CashiersResponse> getFilteredCashier(BaseFilterListParameter filterBodyParameter, bool isAscending);

  Future<bool> editCashier(EditCashierParameter editCashierParameter);

  Future<bool> deleteCashier(DeleteCashierParameter deleteCashierParameter);

  Future<bool> addCashier(AddCashierParameter addCashierParameter);

  Future<CashierRolesResponse> getCashierRoles();
}

@LazySingleton(as: ICashierRemoteDataSource)
class CashierRemoteDataSource extends ICashierRemoteDataSource with RequestCancelToken {
  final Dio _dioClient;

  CashierRemoteDataSource(this._dioClient);

  @override
  Future<CashierSummerizedResponse> getAllCashiersOnce(GetCashiersParameter parameter) async {
    try {
      final Response response =
          await _dioClient.get("Cashier/GetSummarizedInfo", queryParameters: parameter.toJson());

      if (response.statusCode == 200) {
        final CashierSummerizedResponse cashiersResponse = CashierSummerizedResponse.fromJson(response.data);
        return cashiersResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<CashiersResponse> getAllCashiers(BaseFilterListParameter filterBodyParameter) async {
    try {
      final Response response =
          await _dioClient.post("Cashier/GetCashierByFilter", data: filterBodyParameter.filterToJson());

      if (response.statusCode == 200) {
        final CashiersResponse cashiersResponse = CashiersResponse.fromJson(response.data);
        return cashiersResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<bool> addCashier(AddCashierParameter addCashierParameter) async {
    try {
      final Response response =
          await _dioClient.post("Cashier/AddCashier/AddCashier", data: addCashierParameter.toJson());

      if (response.statusCode == 200) {
        return true;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<bool> editCashier(EditCashierParameter editCashierParameter) async {
    try {
      final Response response = await _dioClient.post("Cashier/Edit/${editCashierParameter.id}/edit",
          data: editCashierParameter.toJson());

      if (response.statusCode == 200) {
        return true;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<bool> deleteCashier(DeleteCashierParameter deleteCashierParameter) async {
    try {
      final Response response =
          await _dioClient.post("cashier/deletecashier", data: deleteCashierParameter.toJson());

      if (response.statusCode == 200) {
        return true;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<CashierRolesResponse> getCashierRoles() async {
    try {
      final Response response = await _dioClient.get("Cashier/GetAllRoles/GetAllRoles");

      if (response.statusCode == 200) {
        CashierRolesResponse cashierRolesResponse = CashierRolesResponse.fromJson(response.data);
        return cashierRolesResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<CashiersResponse> getFilteredCashier(
      BaseFilterListParameter filterBodyParameter, bool isAscending) async {
    try {
      final Response response = await _dioClient.post("Cashier/GetSalesByCashier?sortAscending=$isAscending",
          data: filterBodyParameter.filterToJson());

      if (response.statusCode == 200) {
        final CashiersResponse cashiersResponse = CashiersResponse.fromJson(response.data);
        return cashiersResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }
}
