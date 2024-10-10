import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/core/constants/defaults.dart';
import 'package:merchant_dashboard/core/utils/exceptions.dart';
import 'package:merchant_dashboard/core/utils/failure.dart';
import 'package:merchant_dashboard/feature/auth/data/data_sources/login_local_datasource.dart';
import 'package:merchant_dashboard/feature/main_screen/data/data_source/main_remote_datasource.dart';
import 'package:merchant_dashboard/feature/main_screen/data/models/entity/merchant_info.dart';
import 'package:merchant_dashboard/feature/main_screen/data/models/response/merchant_info_response.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../models/entity/branch_general_info.dart';
import '../../../signup/data/models/entity/tax.dart';
import '../../../settings/data/models/response/taxes_response.dart';

abstract class IMainRepository {
  Future<Either<Failure, List<MerchantInfo>>> getMerchantInfo();

  String getSelectedMerchantId();

  void logOutUser();

  bool isLoggedInUserG();

  MerchantInfo getLoggedInUserInfo();

  Future<Either<Failure, BranchGeneralInfo>> getBranchGeneralInfo();

  void setSentryScope();

  void logoutUser();
}

@LazySingleton(as: IMainRepository)
class MainRepository extends IMainRepository {
  final IMainRemoteDataSource _mainRemoteDataSource;
  final ILoginLocalDataSource _localDataSource;

  MainRepository(this._mainRemoteDataSource, this._localDataSource);

  @override
  void logoutUser() => _localDataSource.logoutUser();

  @override
  void setSentryScope() {
    final user = _localDataSource.getLoggedInUserInfo();
    Sentry.configureScope((scope) => scope
      ..setTag('open-app', '')
      ..setUser(SentryUser(
        id: user.userId,
        username: user.userName,
        data: {
          'merchantName': user.merchantName,
          'userLevel': user.userLevel,
          'businessId': user.businessId,
          'branchName': user.branchName
        },
      )));
  }

  @override
  Future<Either<Failure, BranchGeneralInfo>> getBranchGeneralInfo() async {
    try {
      final response = await _mainRemoteDataSource.getBranchGeneralInfo();

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, List<MerchantInfo>>> getMerchantInfo() async {
    try {
      final MerchantInfoResponse merchantInfoResponse = await _mainRemoteDataSource.getMerchantInfo();

      return Right(merchantInfoResponse.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  void logOutUser() {
    _localDataSource.logoutUser();
  }

  @override
  String getSelectedMerchantId() {
    return _localDataSource.getSelectedMerchantId();
  }

  @override
  bool isLoggedInUserG() => _localDataSource.getUserLevel() == Defaults.userG;

  @override
  MerchantInfo getLoggedInUserInfo() => MerchantInfo(
      merchantId: _localDataSource.getUserId(),
      merchantName: _localDataSource.getUserMerchantName(),
      email: _localDataSource.getLoggedInUserEmail(),
      phoneNumber: _localDataSource.getLoggedInUserPhoneNumber(),
      userName: _localDataSource.getUserName(),
      merchantUserLevel: _localDataSource.getUserLevel());
}
