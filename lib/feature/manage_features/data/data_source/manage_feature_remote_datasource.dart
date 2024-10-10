import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/feature/dashboard/data/models/params/merchant_branch_parameter.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../core/utils/exceptions.dart';
import '../models/responese/user_plan_features_response.dart';

abstract class IManageFeatureRemoteDataSource {
  Future<UserPlanFeatureResponse> getUserPlanFeatures();
}

@LazySingleton(as: IManageFeatureRemoteDataSource)
class ManageFeatureRemoteDataSource extends IManageFeatureRemoteDataSource {
  final Dio _dioClient;
  ManageFeatureRemoteDataSource(this._dioClient);

  @override
  Future<UserPlanFeatureResponse> getUserPlanFeatures() async {
    try {
      final Response response = await _dioClient.get("BranchSubscription/GetCurrentFeatures",
          queryParameters: MerchantBranchParameter().branchToJson());

      if (response.statusCode == 200) {
        return UserPlanFeatureResponse.fromJson(response.data);
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }
}
