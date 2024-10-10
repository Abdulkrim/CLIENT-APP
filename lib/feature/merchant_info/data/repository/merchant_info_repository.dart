import 'dart:typed_data';

import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/core/utils/exceptions.dart';
import 'package:merchant_dashboard/core/utils/failure.dart';
import 'package:merchant_dashboard/feature/auth/data/data_sources/login_local_datasource.dart';
import 'package:merchant_dashboard/feature/dashboard/data/models/params/merchant_branch_parameter.dart';
import 'package:merchant_dashboard/feature/merchant_info/data/data_source/merchant_info_remote_datasource.dart';
import 'package:merchant_dashboard/feature/merchant_info/data/models/entity/merchant_information.dart';
import 'package:merchant_dashboard/feature/merchant_info/data/models/params/edit_merchant_information_paramter.dart';
import 'package:merchant_dashboard/feature/merchant_info/data/models/params/update_merchant_logo_parameter.dart';
import 'package:merchant_dashboard/feature/merchant_info/data/models/response/merchant_information_response.dart';
import 'package:merchant_dashboard/utils/mixins/mixins.dart';

abstract class IMerchantInfoRepository {
  bool isSelectedMerchantM();

  Future<Either<Failure, MerchantInformation>> getMerchantInformation();

  Future<Either<Failure, bool>> updateMerchantInformation({
    required String address,
    required String facebook,
    required String instagram,
    required String twitter,
    required String firstPhoneNumber,
    required String email,
  });

  Future<Either<Failure, bool>> updateMerchantLogo(
      {required int logoTypeId, required String filename, required String fileMime, required Uint8List byte});

  Future<Either<Failure, bool>> deleteLogo(String imageUrl);
}

@LazySingleton(as: IMerchantInfoRepository)
class MerchantInfoRepository extends IMerchantInfoRepository with ImagesConditions{
  final IMerchantInfoRemoteDataSource _merchantInfoRemoteDataSource;
  final ILoginLocalDataSource _localDataSource;

  MerchantInfoRepository(this._merchantInfoRemoteDataSource, this._localDataSource);

  @override
  bool isSelectedMerchantM() => _localDataSource.getSelectedMerchantId().length == 8;

  @override
  Future<Either<Failure, MerchantInformation>> getMerchantInformation() async {
    try {
      final MerchantInformationResponse merchantInfo =
          await _merchantInfoRemoteDataSource.getMerchantInformation(MerchantBranchParameter());

      return Right(merchantInfo.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, bool>> updateMerchantInformation({
    required String address,
    required String facebook,
    required String instagram,
    required String twitter,
    required String firstPhoneNumber,
    required String email,
  }) async {
    try {
      final bool updateResult = await _merchantInfoRemoteDataSource.updateMerchantInformation(EditMerchantInformationParameter(
        address: address,
        facebook: facebook,
        instagram: instagram,
        twitter: twitter,
        firstPhoneNumber: firstPhoneNumber,
        email: email,
      ));

      return Right(updateResult);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, bool>> updateMerchantLogo(
      {required int logoTypeId, required String filename, required String fileMime, required Uint8List byte}) async {
    try {
      final bool updateResult = await _merchantInfoRemoteDataSource.updateMerchantLogo(
          UpdateMerchantLogoParameter(logoTypeId: logoTypeId, filename: filename, fileMime: fileMime, byte: byte));

      return Right(updateResult);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteLogo(String imageUrl) async {
    try {
      final bool deleteResult = await _merchantInfoRemoteDataSource.deleteLogo(extractIdFromUrl(imageUrl));

      return Right(deleteResult);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }
}
