import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/core/utils/exceptions.dart';
import 'package:merchant_dashboard/feature/settings/data/models/params/add_payment_mode_parameter.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../dashboard/data/models/params/merchant_branch_parameter.dart';
import '../models/response/taxes_response.dart';
import '../models/entity/manage_payment_settings_parameter.dart';
import '../models/params/update_discount_value_parameters.dart';

import '../models/response/payment/payment_settings_response.dart';
import '../models/response/payment/payment_types_response.dart';

abstract class ISettingsRemoteDataSource {
  Future<bool> updateDiscountValue(UpdateDiscountValueParameters parameters);

  Future<bool> managePaymentSettings(ManagePaymentSettingsParameter parameter);

  Future<PaymentSettingsResponse> getPaymentSettings(MerchantBranchParameter parameter);

  Future<PaymentTypesResponse> getPaymentTypes(MerchantBranchParameter parameter);

  Future<PaymentTypesResponse> getBranchSupportedPaymentTypes(MerchantBranchParameter parameter);

  Future<TaxItemResponse> getDefaultTaxValue(MerchantBranchParameter parameter);

  Future<bool> addPaymentMode(AddPaymentModeParameter parameter);
}

@LazySingleton(as: ISettingsRemoteDataSource)
class SettingsRemoteDataSource extends ISettingsRemoteDataSource {
  final Dio _dioClient;

  SettingsRemoteDataSource(this._dioClient);

  @override
  Future<PaymentTypesResponse> getBranchSupportedPaymentTypes(MerchantBranchParameter parameter) async {
    try {
      final Response response = await _dioClient.get("Branch/BranchPaymentModes", queryParameters: parameter.branchToJson());

      if (response.statusCode == 200) {
        final PaymentTypesResponse productsResponse = PaymentTypesResponse.fromJson(response.data);
        return productsResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<PaymentTypesResponse> getPaymentTypes(MerchantBranchParameter parameter) async {
    try {
      final Response response = await _dioClient.get("transaction/PaymentTypes", queryParameters: parameter.branchToJson());

      if (response.statusCode == 200) {
        final PaymentTypesResponse productsResponse = PaymentTypesResponse.fromJson(response.data);
        return productsResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<bool> updateDiscountValue(UpdateDiscountValueParameters parameters) async {
    try {
      final Response response = await _dioClient.post("BranchSettings/ApplyDiscountToProducts", data: parameters.toJson());

      if (response.statusCode == 200) {
        return true;
      }

      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<TaxItemResponse> getDefaultTaxValue(MerchantBranchParameter parameter) async {
    try {
      final Response response = await _dioClient.get("Tax/CountryTaxByBranch", queryParameters: parameter.branchToJson());

      if (response.statusCode == 200) {
        return TaxItemResponse.fromJson(response.data);
      }

      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<bool> addPaymentMode(AddPaymentModeParameter parameter) async {
    try {
      final Response response = await _dioClient.post("Transaction/CreatePaymentType", data: parameter.toJson());

      if (response.statusCode == 200) {
        return true;
      }

      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<bool> managePaymentSettings(ManagePaymentSettingsParameter parameter) async {
    try {
      final Response response = await _dioClient.post("BranchSettings/ManagePaymentAndTaxSettings", data: parameter.toJson());

      if (response.statusCode == 200) {
        return true;
      }

      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<PaymentSettingsResponse> getPaymentSettings(MerchantBranchParameter parameter) async {
    try {
      final Response response =
          await _dioClient.get("BranchSettings/PaymentAndTaxSettings", queryParameters: parameter.branchToJson());

      if (response.statusCode == 200) {
        return PaymentSettingsResponse.fromJson(response.data);
      }

      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }
}
