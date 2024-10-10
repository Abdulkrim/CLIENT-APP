import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/core/client/parameter/base_filter_parameter.dart';
import 'package:merchant_dashboard/core/constants/defaults.dart';
import 'package:merchant_dashboard/feature/dashboard/data/models/params/merchant_branch_parameter.dart';
import 'package:merchant_dashboard/feature/loyalty/data/models/params/manage_loyalty_settings_parameter.dart';

import '../../../../core/utils/exceptions.dart';
import '../../../../core/utils/failure.dart';
import '../data_source/loyalty_point_remote_datasource.dart';
import '../models/entity/loyalty_point.dart';
import '../models/entity/loyalty_settings.dart';

abstract class ILoyaltyPointRepository {
  Future<Either<Failure, LoyaltyPoint>> getLoyaltyPointHistory({
    required String customerId,
    required String fromDate,
    required String toDate,
    required int page,
  });

  Future<Either<Failure, LoyaltySettings>> getLoyaltySettings();

  Future<Either<Failure, bool>> manageLoyaltySettings(
      {required bool loyaltyAllowed,
      required bool isSplitAllowed,
      required num rechargePoint,
      required num redeemPoint,
      required num expireDuration,
      required num remainedDaysToExpirePointToNotifyCustomer,
      required num maxExpiringPointToNotifyCustomer,
      required num maxPercent});
}

@LazySingleton(as: ILoyaltyPointRepository)
class LoyaltyPointRepository extends ILoyaltyPointRepository {
  final ILoyaltyPointRemoteDataSource _loyaltyPointsRemoteDataSource;

  LoyaltyPointRepository(this._loyaltyPointsRemoteDataSource);

  @override
  Future<Either<Failure, LoyaltyPoint>> getLoyaltyPointHistory({
    required String customerId,
    required String fromDate,
    required String toDate,
    required int page,
  }) async {
    try {
      final parameter = BaseFilterListParameter(filterInfo: [
        BaseFilterInfoParameter(
            logical: LogicalOperator.and.value,
            operator: QueryOperator.greaterThanOrEqualTo.value,
            propertyName: 'Date',
            value: fromDate),
        BaseFilterInfoParameter(
            logical: LogicalOperator.and.value,
            operator: QueryOperator.lessThanOrEqualTo.value,
            propertyName: 'Date',
            value: toDate),
      ], page: page);

      final response = await _loyaltyPointsRemoteDataSource.getLoyaltyPointResponse(parameter, customerId);

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, LoyaltySettings>> getLoyaltySettings() async {
    try {
      final response = await _loyaltyPointsRemoteDataSource.getLoyaltySettings(MerchantBranchParameter());

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, bool>> manageLoyaltySettings(
      {required bool loyaltyAllowed,
      required bool isSplitAllowed,
      required num rechargePoint,
      required num redeemPoint,
      required num expireDuration,
      required num remainedDaysToExpirePointToNotifyCustomer,
      required num maxExpiringPointToNotifyCustomer,
      required num maxPercent}) async {
    try {
      final response = await _loyaltyPointsRemoteDataSource.manageLoyaltySettings(
          ManageLoyaltySettingsParameter(
              loyaltyAllowed: loyaltyAllowed,
              isSplitAllowed: isSplitAllowed,
              rechargePoint: rechargePoint,
              redeemPoint: redeemPoint,
              expireDuration: expireDuration,
              remainedDaysToExpirePointToNotifyCustomer: remainedDaysToExpirePointToNotifyCustomer,
              maxExpiringPointToNotifyCustomer: maxExpiringPointToNotifyCustomer,
              maxPercent: maxPercent));

      return Right(response);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }
}
