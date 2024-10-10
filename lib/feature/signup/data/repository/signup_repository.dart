import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/core/utils/failure.dart';
import 'package:merchant_dashboard/feature/auth/data/data_sources/login_local_datasource.dart';
import 'package:merchant_dashboard/feature/signup/data/data_source/signup_remote_datasource.dart';
import 'package:merchant_dashboard/feature/signup/data/models/entity/business_type.dart';
import 'package:merchant_dashboard/feature/signup/data/models/params/add_branch_parameter.dart';

import '../../../../core/utils/exceptions.dart';
import '../models/params/save_signup_steps_parameter.dart';
import '../models/response/business_type/business_types_response.dart';

abstract class ISignUpRepository {
  Future<Either<Failure, List<BusinessType>>> getBusinessTypes();

  Future<Either<Failure, String>> addBranchInfo({
    required String name,
    required String phoneNumber,
    required String email,
    required String branchAddress,
    required int businessTypeId,
    required String domainAddress,
    required int? cityId,
    required String cityName,
    required int countryId,
  });

  void saveHasBranch(bool hasBranch);

  Future<Either<Failure, bool>> validateBusinessName(String businessName);

  Future<Either<Failure, bool>> validateBusinessDomain(String businessDomain);

  Future<Either<Failure, bool>> saveSetupGuideData(SaveSignupStepsParameter parameter);
}

@LazySingleton(as: ISignUpRepository)
class SignUpRepository extends ISignUpRepository {
  final ILoginLocalDataSource _localDataSource;
  final ISignUpRemoteDataSource _signUpRemoteDataSource;

  SignUpRepository(this._signUpRemoteDataSource, this._localDataSource);

  @override
  void saveHasBranch(bool hasBranch) => _localDataSource.saveHasBranch(hasBranch);



  @override
  Future<Either<Failure, List<BusinessType>>> getBusinessTypes() async {
    try {
      final BusinessTypesResponse response = await _signUpRemoteDataSource.getBusinessTypes();

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, String>> addBranchInfo({
    required String name,
    required String phoneNumber,
    required String email,
    required String branchAddress,
    required String domainAddress,
    required int businessTypeId,
    required int? cityId,
    required String cityName,
    required int countryId,
  }) async {
    try {
      final String response = await _signUpRemoteDataSource.addBranchInfo(AddBranchParameter(
          domainAddress: domainAddress,
          name: name,
          phoneNumber: phoneNumber,
          email: email,
          branchAddress: branchAddress,
          businessTypeId: businessTypeId,
          cityId: cityId,
          cityName: cityName,
          countryId: countryId));

      // Save created branchId to local storage
      _localDataSource.setSelectedMerchantId(merchantId: response);

      return Right(response);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, bool>> validateBusinessName(String businessName) async {
    try {
      final bool response = await _signUpRemoteDataSource.validateBusinessName(businessName);

      return Right(response);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, bool>> validateBusinessDomain(String businessDomain) async {
    try {
      final bool response = await _signUpRemoteDataSource.validateBusinessDomain(businessDomain);

      return Right(response);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, bool>> saveSetupGuideData(SaveSignupStepsParameter parameter) async {
    try {
      final bool response = await _signUpRemoteDataSource.saveSetupGuideData(parameter);

      return Right(response);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }
}
