import 'package:injectable/injectable.dart';
import 'package:either_dart/either.dart';
import 'package:merchant_dashboard/core/utils/exceptions.dart';
import 'package:merchant_dashboard/core/utils/failure.dart';
import 'package:merchant_dashboard/feature/auth/data/data_sources/login_local_datasource.dart';
import 'package:merchant_dashboard/feature/auth/data/data_sources/login_remote_datasource.dart';
import 'package:merchant_dashboard/feature/auth/data/models/entities/user_data.dart';
import 'package:merchant_dashboard/feature/auth/data/models/params/register_request_parameter.dart';
import 'package:merchant_dashboard/feature/auth/data/models/params/login_request_parameter.dart';
import 'package:merchant_dashboard/feature/auth/data/models/params/reset_password_parameter.dart';
import 'package:merchant_dashboard/feature/auth/data/models/responses/login_response.dart';

abstract class ILoginRepository {
  Future<Either<Failure, UserData>> loginUserThroughUserName(LoginRequestParameter loginRequestParameter);

  Future<Either<Failure, bool>> forgetPassword(String email);

  Future<Either<Failure, bool>> resetPassword({required String email, required String code, required String newPassword});

  Future<Either<Failure, ({String userId, String password})>> registerMobile({required String phoneNumber});

  Future<Either<Failure, bool>> registerEmail({required String email, required String userId, required String password});
}

@LazySingleton(as: ILoginRepository)
class LoginRepository extends ILoginRepository {
  final ILoginRemoteDataSource _loginRemoteDataSource;
  final ILoginLocalDataSource _localDataSource;

  LoginRepository(this._loginRemoteDataSource, this._localDataSource);

  @override
  Future<Either<Failure, UserData>> loginUserThroughUserName(LoginRequestParameter loginRequestParameter) async {
    try {
      final LoginResponse loginResponse = await _loginRemoteDataSource.loginRequest(loginRequestParameter);

      UserData userData = loginResponse.toEntity();

      if (!userData.isBranchOrBusiness) {
        return Left(RequestError("You do not have access to login."));
      } else {
        _localDataSource.saveUserInfo(
            userToken: userData.accessToken,
            userRefreshToken: userData.refreshToken,
            userName: userData.userName,
            merchantName: userData.merchantName,
            hasBranch: userData.hasBranch,
            userId: userData.merchantId,
            userLevel: userData.role,
            branchName: userData.branchName,
            phoneNumber: userData.phoneNumber,
            branchEmail: userData.branchEmail,
            businessId: userData.businessId,
            registeredDate: userData.registeredDate);


        return Right(userData);
      }
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, bool>> forgetPassword(String email) async {
    try {
      final response = await _loginRemoteDataSource.forgetPassword(email);

      return Right(response);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, bool>> resetPassword({required String email, required String code, required String newPassword}) async {
    try {
      final response =
          await _loginRemoteDataSource.resetPassword(ResetPasswordParameter(email: email, code: code, password: newPassword));

      return Right(response);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, ({String userId, String password})>> registerMobile({required String phoneNumber}) async {
    try {
      final registerApiResponse =
          await _loginRemoteDataSource.registerMobile(RegisterRequestParameter.mobileRegistration(phoneNumber: phoneNumber));

      return Right(registerApiResponse);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, bool>> registerEmail({required String email, required String userId, required String password}) async {
    try {
      final registerApiResponse = await _loginRemoteDataSource
          .registerEmail(RegisterRequestParameter.emailRegistration(email: email, userId: userId, password: password));

      return Right(registerApiResponse);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }
}
