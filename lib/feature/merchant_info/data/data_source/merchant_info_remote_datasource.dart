import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/core/utils/exceptions.dart';
import 'package:merchant_dashboard/feature/merchant_info/data/models/params/edit_merchant_information_paramter.dart';
import 'package:merchant_dashboard/feature/merchant_info/data/models/params/update_merchant_logo_parameter.dart';
import 'package:merchant_dashboard/feature/merchant_info/data/models/response/merchant_information_response.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../dashboard/data/models/params/merchant_branch_parameter.dart';

abstract class IMerchantInfoRemoteDataSource {
  Future<MerchantInformationResponse> getMerchantInformation(MerchantBranchParameter parameter);

  Future<bool> updateMerchantInformation(EditMerchantInformationParameter parameter);

  Future<bool> updateMerchantLogo(UpdateMerchantLogoParameter parameter);

  Future<bool> deleteLogo(String imageId);
}

@LazySingleton(as: IMerchantInfoRemoteDataSource)
class MerchantInfoRemoteDataSource extends IMerchantInfoRemoteDataSource {
  final Dio _dioClient;

  MerchantInfoRemoteDataSource(this._dioClient);

  @override
  Future<MerchantInformationResponse> getMerchantInformation(MerchantBranchParameter parameter) async {
    try {
      final Response response = await _dioClient.get("Branch/BranchInfo", queryParameters: parameter.branchToJson());

      if (response.statusCode == 200) {
        MerchantInformationResponse merchantInformationResponse = MerchantInformationResponse.fromJson(response.data);
        return merchantInformationResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<bool> updateMerchantInformation(EditMerchantInformationParameter parameter) async {
    try {
      final Response response = await _dioClient.patch("Branch/EditBranchInfo", data: parameter.toJson());

      if (response.statusCode == 200) {
        return true;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<bool> updateMerchantLogo(UpdateMerchantLogoParameter parameter) async {
    try {
      final Response response = await _dioClient.post("Branch/UploadLogo", data: parameter.toFormData());

      if (response.statusCode == 200) {
        return true;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<bool> deleteLogo(String imageId) async {
    try {
      final Response response = await _dioClient.delete("Image/Delete", queryParameters: {'imageId': imageId});

      if (response.statusCode == 200) {
        return true;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }
}
