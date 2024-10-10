import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/core/utils/failure.dart';
import 'package:merchant_dashboard/feature/dashboard/data/models/params/merchant_branch_parameter.dart';
import 'package:merchant_dashboard/feature/online_ordering/data/data_source/online_ordering_datasource.dart';
import 'package:merchant_dashboard/feature/online_ordering/data/models/entity/message_settings.dart';
import 'package:merchant_dashboard/feature/online_ordering/data/models/params/get_messages_parameter.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../core/utils/exceptions.dart';
import '../models/entity/online_ordering_settings.dart';
import '../models/params/update_messages_settings_parameter.dart';
import '../models/params/update_online_ordering_settings_parameter.dart';

abstract class IOnlineOrderingRepository {
  Future<Either<Failure, OnlineOrderingSettings>> getOnlineOrderingSettings();

  Future<Either<Failure, List<MessageSettings>>> getMessagesSetting();

  Future<Either<Failure, bool>> updateMessagesSettings(
      {required String engMessage, required String arMessage, required String frMessage, required String trMessage});

  Future<Either<Failure, bool>> updateOnlineSettings(
      {required bool onlineOrderingAllowed, required bool whatsappOrderingAllowed, required String whatsappNumber});
}

@LazySingleton(as: IOnlineOrderingRepository)
class OnlineOrderingRepository extends IOnlineOrderingRepository {
  final IOnlineOrderingRemoteDataSource _onlineOrderingRemoteDataSource;

  OnlineOrderingRepository(this._onlineOrderingRemoteDataSource);

  @override
  Future<Either<Failure, OnlineOrderingSettings>> getOnlineOrderingSettings() async {
    try {
      final result = await _onlineOrderingRemoteDataSource.getOnlineOrderingSettings(MerchantBranchParameter());

      return Right(result.toEntity());
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<Either<Failure, List<MessageSettings>>> getMessagesSetting() async {
    try {
      final result = await _onlineOrderingRemoteDataSource.getMessagesSetting(GetMessagesParameter.closeMessages());

      return Right(result.toEntity());
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<Either<Failure, bool>> updateMessagesSettings(
      {required String engMessage, required String arMessage, required String frMessage, required String trMessage}) async {
    try {
      final result = await _onlineOrderingRemoteDataSource.updateMessagesSettings(UpdateMessagesSettingsParameter.closingMessage(
        enMessage: engMessage,
        frMessage: frMessage,
        trMessage: trMessage,
        arMessage: arMessage,
      ));

      return Right(result);
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<Either<Failure, bool>> updateOnlineSettings(
      {required bool onlineOrderingAllowed, required bool whatsappOrderingAllowed, required String whatsappNumber}) async {
    try {
      final result = await _onlineOrderingRemoteDataSource.updateOnlineSettings(UpdateOnlineOrderingSettingsParameter(
        onlineOrderingAllowed: onlineOrderingAllowed,
        whatsappOrderingAllowed: whatsappOrderingAllowed,
        whatsappNumber: whatsappNumber,
      ));

      return Right(result);
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }
}
