import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/core/utils/exceptions.dart';
import 'package:merchant_dashboard/feature/dashboard/data/models/params/merchant_branch_parameter.dart';
import 'package:merchant_dashboard/feature/main_screen/data/models/response/merchant_info_response.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../models/response/branch_general_info_response.dart';

abstract class IMainRemoteDataSource {
  Future<MerchantInfoResponse> getMerchantInfo();



  Future<BranchGeneralInfoResponse> getBranchGeneralInfo();
}

@LazySingleton(as: IMainRemoteDataSource)
class MainRemoteDataSource extends IMainRemoteDataSource {
  final Dio _dioClient;

  MainRemoteDataSource(this._dioClient);

  @override
  Future<BranchGeneralInfoResponse> getBranchGeneralInfo() async {
    try {
      final Response response =
          await _dioClient.get('Branch/BranchGeneralInfo', queryParameters: MerchantBranchParameter().branchToJson());

      if (response.statusCode == 200) {
        final BranchGeneralInfoResponse convertedResponse = BranchGeneralInfoResponse.fromJson(response.data);
        return convertedResponse;
      }
      throw const RequestException('Reuest has an error');
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<MerchantInfoResponse> getMerchantInfo() async {
    try {
      Response response = await _dioClient.get("Branch/GetBranchesByBusinessId");

      if (response.statusCode == 200) {
        final MerchantInfoResponse merchantInfoResponse = MerchantInfoResponse.fromJson(response.data);
        return merchantInfoResponse;
      }

      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

}
