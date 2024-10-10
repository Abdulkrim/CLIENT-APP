import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/core/utils/failure.dart';
import 'package:merchant_dashboard/feature/manage_features/data/data_source/manage_feature_remote_datasource.dart';
import 'package:merchant_dashboard/feature/manage_features/data/models/entity/user_plan_feature.dart';

import '../../../../core/utils/exceptions.dart';

abstract class IManageFeaturesRepository {
  Future<Either<Failure, List<UserPlanFeature>>> getUserPlanFeatures();

  bool isFeatureEnable(String appFeatureKey, List<UserPlanFeature> features);
}

@LazySingleton(as: IManageFeaturesRepository)
class ManageFeaturesRepository extends IManageFeaturesRepository {
  final IManageFeatureRemoteDataSource _manageFeatureRemoteDataSource;

  ManageFeaturesRepository(this._manageFeatureRemoteDataSource);

  @override
  bool isFeatureEnable(String appFeatureKey, List<UserPlanFeature> features) =>
      features.map((e) => e.fkey.toLowerCase()).toList().toSet().contains(appFeatureKey.toLowerCase().trim());

  @override
  Future<Either<Failure, List<UserPlanFeature>>> getUserPlanFeatures() async {
    try {
      final result = await _manageFeatureRemoteDataSource.getUserPlanFeatures();

      return Right(result.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }
}
