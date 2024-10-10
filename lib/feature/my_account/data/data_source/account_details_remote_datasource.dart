import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/core/utils/exceptions.dart';
import 'package:merchant_dashboard/feature/my_account/data/models/params/account_details_parameter.dart';
import 'package:merchant_dashboard/feature/my_account/data/models/params/update_account_details_parameter.dart';
import 'package:merchant_dashboard/feature/my_account/data/models/response/account_details_response.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

abstract class IAccountDetailsRemoteDataSource {
  Future<AccountDetailsResponse> getAccountDetails(AccountDetailsParameter parameter);

  Future<bool> updateAccountDetails(UpdateAccountDetailsParameter parameter);

  Future<bool> sendDeletionEmail(String userEmail);
  Future<bool> verifyDeletionOtp(String otpCode);
}

@LazySingleton(as: IAccountDetailsRemoteDataSource)
class AccountDetailsRemoteDataSource extends IAccountDetailsRemoteDataSource {
  final Dio _dioClient;

  AccountDetailsRemoteDataSource(this._dioClient);

  @override
  Future<AccountDetailsResponse> getAccountDetails(AccountDetailsParameter parameter) async {
    try {
      final Response response =
          await _dioClient.get("account/GetAccountDetails", queryParameters: parameter.toJson());

      if (response.statusCode == 200) {
        final AccountDetailsResponse accountDetailsResponse = AccountDetailsResponse.fromJson(response.data);
        return accountDetailsResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<bool> updateAccountDetails(UpdateAccountDetailsParameter parameter) async {
    try {
      final Response response = await _dioClient.post("account/EditAccount",
          queryParameters: parameter.qToJson(), data: parameter.toJson());

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
  Future<bool> sendDeletionEmail(String userEmail) async {
    try {
      final Response response =
          await _dioClient.post("OTP/SendMail", queryParameters: {'useremail': userEmail});

      if (response.data['statusCode'] == 201) {
        return true;
      }
      throw RequestException(response.data['message'] ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<bool> verifyDeletionOtp(String otpCode) async {
    try {
      final Response response = await _dioClient.delete("User", queryParameters: {'enteredOtp': otpCode});

      if (response.statusCode == 204) {
        return true;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }
}
