import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/core/utils/exceptions.dart';
import 'package:merchant_dashboard/feature/auth/data/models/params/register_request_parameter.dart';
import 'package:merchant_dashboard/feature/auth/data/models/params/login_request_parameter.dart';
import 'package:merchant_dashboard/feature/auth/data/models/responses/login_response.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../models/params/reset_password_parameter.dart';

abstract class ILoginRemoteDataSource {
  Future<LoginResponse> loginRequest(LoginRequestParameter loginRequestParameter);

  Future<({String userId, String password})> registerMobile(RegisterRequestParameter parameter);

  Future<bool> registerEmail(RegisterRequestParameter parameter);

  Future<bool> forgetPassword(String email);

  Future<bool> resetPassword(ResetPasswordParameter parameter);
}

@LazySingleton(as: ILoginRemoteDataSource)
class LoginRemoteDataSource extends ILoginRemoteDataSource {
  final Dio _dioClient;

  LoginRemoteDataSource(this._dioClient);

  @override
  Future<LoginResponse> loginRequest(LoginRequestParameter loginRequestParameter) async {
    try {
      Response response = await _dioClient.post("User/login", data: loginRequestParameter.toJson());

      if (response.statusCode == 200) {
        final LoginResponse loginResponse = LoginResponse.fromJson(response.data);
        return loginResponse;
      }

      throw const RequestException("The username or password is incorrect.");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<bool> forgetPassword(String email) async {
    try {
      Response response = await _dioClient.post("User/forget-password", queryParameters: {'email': email});

      if (response.statusCode == 200) {
        return true;
      }

      throw const RequestException("The username or password is incorrect.");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<bool> resetPassword(ResetPasswordParameter parameter) async {
    try {
      Response response = await _dioClient.post("User/reset-password", data: parameter.toJson());

      if (response.statusCode == 200) {
        return true;
      }

      throw const RequestException("The username or password is incorrect.");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<({String userId, String password})> registerMobile(RegisterRequestParameter parameter) async {
    try {
      Response response = await _dioClient.post("User/RegisterByMobile", data: parameter.mobileStepToJson());

      if (response.data case {"password": String pass, "userId": String userId}) {
        return (userId: userId, password: pass);
      }

      throw const RequestException("The username or password is incorrect.");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<bool> registerEmail(RegisterRequestParameter parameter) async {
    try {
      Response response = await _dioClient.post("User/CompleteRegisteration", data: parameter.emailStepToJson());

      if (response.statusCode == 200) {
        return true;
      }

      throw const RequestException("The username or password is incorrect.");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }
}
