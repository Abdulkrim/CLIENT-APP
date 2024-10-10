import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/feature/dashboard/data/models/params/merchant_branch_parameter.dart';
import 'package:merchant_dashboard/feature/online_ordering/data/models/params/update_messages_settings_parameter.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../core/utils/exceptions.dart';
import '../models/params/get_messages_parameter.dart';
import '../models/params/update_online_ordering_settings_parameter.dart';
import '../models/response/messages_settings_response.dart';
import '../models/response/online_ordering_settings_response.dart';

abstract class IOnlineOrderingRemoteDataSource {
  Future<OnlineOrderingSettingsResponse> getOnlineOrderingSettings(MerchantBranchParameter parameter);

  Future<MessagesSettingsResponse> getMessagesSetting(GetMessagesParameter parameter);

  Future<bool> updateMessagesSettings(UpdateMessagesSettingsParameter parameter);
  Future<bool> updateOnlineSettings(UpdateOnlineOrderingSettingsParameter parameter);
}

@LazySingleton(as: IOnlineOrderingRemoteDataSource)
class OnlineOrderingRemoteDataSource extends IOnlineOrderingRemoteDataSource {
  final Dio _dioClient;

  OnlineOrderingRemoteDataSource(this._dioClient);

  @override
  Future<OnlineOrderingSettingsResponse> getOnlineOrderingSettings(MerchantBranchParameter parameter) async {
    try {
      final Response response =
          await _dioClient.get("BranchSettings/GeOnlineOrderingSetting", queryParameters: parameter.branchToJson());

      if (response.statusCode == 200) {
        return OnlineOrderingSettingsResponse.fromJson(response.data);
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<MessagesSettingsResponse> getMessagesSetting(GetMessagesParameter parameter) async {
    try {
      final Response response =
      await _dioClient.get("BranchSettings/GetBranchMessage", queryParameters: parameter.toJson());

      if (response.statusCode == 200) {
        return MessagesSettingsResponse.fromJson(response.data);
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<bool> updateMessagesSettings(UpdateMessagesSettingsParameter parameter) async {
    try {
      final Response response =
      await _dioClient.post("BranchSettings/ManageBranchMessage", data: parameter.toJson());

      return response.statusCode == 200;
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }


  @override
  Future<bool> updateOnlineSettings(UpdateOnlineOrderingSettingsParameter parameter)  async {
    try {
      final Response response =
      await _dioClient.post("BranchSettings/ManageOnlineOrderingSetting", data: parameter.toJson());

      return response.statusCode == 200;
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }
}
