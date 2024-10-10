import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/feature/dashboard/data/models/params/merchant_branch_parameter.dart';
import 'package:merchant_dashboard/feature/device/data/models/response/devices_response.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../core/utils/exceptions.dart';
import '../../../settings/data/models/params/update_optional_parameters.dart';
import '../models/params/update_pos_settings_parameter.dart';
import '../models/response/optional_params/optional_param_response.dart';
import '../models/response/pos_settings_response.dart';

abstract class IDeviceRemoteDataSource {
  Future<DevicesResponse> getDevices();

  Future<bool> checkHasPos();

  Future<OptionalParametersResponse> getOptionalParameters(MerchantBranchParameter parameter);

  Future<bool> updateOptionalParameters(UpdateOptionalParameters parameters);

  Future<PosSettingsResponse> getPOSSetting(MerchantBranchParameter parameter);

  Future<bool> updatePOSSettings(UpdatePOSSettingsParameter parameters);
}

@LazySingleton(as: IDeviceRemoteDataSource)
class DeviceRemoteDataSource extends IDeviceRemoteDataSource {
  final Dio _dioClient;

  DeviceRemoteDataSource(this._dioClient);

  @override
  Future<DevicesResponse> getDevices() async {
    try {
      final Response response = await _dioClient.get("Device/Types");

      if (response.statusCode == 200) {
        final DevicesResponse productsResponse = DevicesResponse.fromJson(response.data);
        return productsResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<bool> checkHasPos() async {
    try {
      final Response response =
          await _dioClient.get("Pos/Devices", queryParameters: MerchantBranchParameter().branchToJson());

      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<OptionalParametersResponse> getOptionalParameters(MerchantBranchParameter parameter) async {
    try {
      final Response response = await _dioClient.get("BranchSettings/GetBranchOptionalParams",
          queryParameters: parameter.branchToJson());

      if (response.statusCode == 200) {
        final OptionalParametersResponse productsResponse =
            OptionalParametersResponse.fromJson(response.data);
        return productsResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<bool> updateOptionalParameters(UpdateOptionalParameters parameters) async {
    try {
      final Response response =
          await _dioClient.post("BranchSettings/SetBranchOptionalParams", data: parameters.toJson());

      if (response.statusCode == 200) {
        return true;
      }

      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<bool> updatePOSSettings(UpdatePOSSettingsParameter parameters) async {
    try {
      final response =
          await _dioClient.post("BranchSettings/ManagePosSettings", data: parameters.toFormData());

      if (response.statusCode == 200) {
        return true;
      }

      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<PosSettingsResponse> getPOSSetting(MerchantBranchParameter parameter) async {
    try {
      final response =
          await _dioClient.get("BranchSettings/PosSettings", queryParameters: parameter.branchToJson());

      if (response.statusCode == 200) {
        return PosSettingsResponse.fromJson(response.data);
      }

      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }
}
