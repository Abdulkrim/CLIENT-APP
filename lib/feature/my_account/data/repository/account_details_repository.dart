import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/core/utils/exceptions.dart';
import 'package:merchant_dashboard/core/utils/failure.dart';
import 'package:merchant_dashboard/feature/auth/data/data_sources/login_local_datasource.dart';
import 'package:merchant_dashboard/feature/my_account/data/data_source/account_details_remote_datasource.dart';
import 'package:merchant_dashboard/feature/my_account/data/models/entity/account_details.dart';
import 'package:merchant_dashboard/feature/my_account/data/models/params/account_details_parameter.dart';
import 'package:merchant_dashboard/feature/my_account/data/models/params/update_account_details_parameter.dart';
import 'package:merchant_dashboard/feature/my_account/data/models/response/account_details_response.dart';

abstract class IAccountDetailsRepository {
  Future<Either<Failure, AccountDetails>> getAllAccountDetails();

  Future<Either<Failure, bool>> updateAccountDetails(String fieldKey, String fieldValue);

  Future<Either<Failure, bool>> sendDeletionEmail(String userEmail);
  Future<Either<Failure, bool>> verifyDeletionOtp(String otpCode);
}

@LazySingleton(as: IAccountDetailsRepository)
class AccountDetailsRepository extends IAccountDetailsRepository {
  final ILoginLocalDataSource _localDataSource;
  final IAccountDetailsRemoteDataSource _accountDetailsRemoteDataSource;

  AccountDetailsRepository(this._accountDetailsRemoteDataSource, this._localDataSource);

  @override
  Future<Either<Failure, AccountDetails>> getAllAccountDetails() async {
    try {
      final AccountDetailsResponse accountDetailsResponse = await _accountDetailsRemoteDataSource
          .getAccountDetails(AccountDetailsParameter(merchantId: _localDataSource.getUserId()));

      return Right(accountDetailsResponse.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, bool>> updateAccountDetails(String fieldKey, String fieldValue) async {
    try {
      final bool updateResult =
          await _accountDetailsRemoteDataSource.updateAccountDetails(UpdateAccountDetailsParameter(
        fieldKey: fieldKey,
        fieldValue: fieldValue,
        userId: _localDataSource.getUserId(),
      ));

      return Right(updateResult);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, bool>> sendDeletionEmail(String userEmail) async {
    try {
      final bool updateResult = await _accountDetailsRemoteDataSource.sendDeletionEmail(userEmail);

      return Right(updateResult);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, bool>> verifyDeletionOtp(String otpCode) async {
    try {
      final bool updateResult = await _accountDetailsRemoteDataSource.verifyDeletionOtp(otpCode);

      _localDataSource.logoutUser();

      return Right(updateResult);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }
}
