import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/core/client/parameter/base_filter_parameter.dart';
import 'package:merchant_dashboard/feature/dashboard/data/models/params/merchant_branch_parameter.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../core/utils/exceptions.dart';
import '../models/params/manage_loyalty_settings_parameter.dart';
import '../models/response/loyalty_settings/loyalty_settings_response.dart';
import '../models/response/point_history/loyalty_point_history_response.dart';

abstract class ILoyaltyPointRemoteDataSource {
  Future<LoyaltyPointHistoryResponse> getLoyaltyPointResponse(
      BaseFilterListParameter parameter, String customerId);

  Future<LoyaltySettingsResponse> getLoyaltySettings(MerchantBranchParameter parameter);

  Future<bool> manageLoyaltySettings(ManageLoyaltySettingsParameter parameter);
}

@LazySingleton(as: ILoyaltyPointRemoteDataSource)
class LoyaltyPointRemoteDataSource extends ILoyaltyPointRemoteDataSource {
  final Dio _dioClient;

  LoyaltyPointRemoteDataSource(this._dioClient);

  @override
  Future<LoyaltyPointHistoryResponse> getLoyaltyPointResponse(
      BaseFilterListParameter parameter, String customerId) async {
    try {
      final Response response = await _dioClient.post("Customer/GetCustomerLoyaltyHistory",
          data: parameter.filterToJson(), queryParameters: {'customerId': customerId});

      if (response.statusCode == 200) {
        return LoyaltyPointHistoryResponse.fromJson(response.data);
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<LoyaltySettingsResponse> getLoyaltySettings(MerchantBranchParameter parameter) async {
    try {
      final Response response =
          await _dioClient.get("BranchSettings/GetLoyaltySetting", queryParameters: parameter.branchToJson());

      if (response.statusCode == 200) {
        return LoyaltySettingsResponse.fromJson(response.data);
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<bool> manageLoyaltySettings(ManageLoyaltySettingsParameter parameter) async {
    try {
      final Response response =
          await _dioClient.post("BranchSettings/ManageLoyaltySetting", data: parameter.toJson());

      if (response.statusCode == 200) {
        return true;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }
}
