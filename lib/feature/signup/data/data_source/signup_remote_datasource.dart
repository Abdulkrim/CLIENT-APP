import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/core/client/request_cancel_token.dart';
import 'package:merchant_dashboard/feature/signup/data/models/params/save_signup_steps_parameter.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import '../../../../core/utils/exceptions.dart';
import '../models/params/add_branch_parameter.dart';
import '../models/response/business_type/business_types_response.dart';

abstract class ISignUpRemoteDataSource {
  Future<BusinessTypesResponse> getBusinessTypes();

  Future<String> addBranchInfo(AddBranchParameter parameter);

  Future<bool> saveSetupGuideData(SaveSignupStepsParameter parameter);

  Future<bool> validateBusinessName(String businessName);

  Future<bool> validateBusinessDomain(String businessDomain);
}

@LazySingleton(as: ISignUpRemoteDataSource)
class SignUpRemoteDataSource extends ISignUpRemoteDataSource with RequestCancelToken {
  final Dio _dioClient;

  SignUpRemoteDataSource(this._dioClient);

  @override
  Future<BusinessTypesResponse> getBusinessTypes() async {
    try {
      final Response response = await _dioClient.get("Business/GetBusinessType");

      if (response.statusCode == 200) {
        final BusinessTypesResponse convertedResponse = BusinessTypesResponse.fromJson(response.data);
        return convertedResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<String> addBranchInfo(AddBranchParameter parameter) async {
    try {
      final Response response = await _dioClient.post("Branch/AddBranchWithAddress", data: parameter.toJson());

      if (response.data case {'isSucceeded': bool _, 'branchId': String branchId}) {
        return branchId;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      if (error.response?.data case {'errors': List<dynamic> errors}) {
        throw RequestException(errors.firstOrNull);
      }
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<bool> validateBusinessName(String businessName) async {
    try {
      cancelAllRequests();

      final cancelToken = getCancelToken('Branch/IsBranchNameValid');
      final Response response =
          await _dioClient.get("Branch/IsBranchNameValid", cancelToken: cancelToken, queryParameters: {'name': businessName});

      if (response.statusCode == 200) {
        return response.data;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      if (error.response?.data case {'errors': List<dynamic> errors}) {
        throw RequestException(errors.firstOrNull);
      }
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<bool> validateBusinessDomain(String businessDomain) async {
    try {
      cancelAllRequests();

      final cancelToken = getCancelToken('Branch/IsDomainValid');
      final Response response =
          await _dioClient.get("Branch/IsDomainValid", cancelToken: cancelToken, queryParameters: {'domainName': businessDomain});

      if (response.statusCode == 200) {
        return response.data;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      if (error.response?.data case {'errors': List<dynamic> errors}) {
        throw RequestException(errors.firstOrNull);
      }
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<bool> saveSetupGuideData(SaveSignupStepsParameter parameter) async {
    try {
      final Response response = await _dioClient.post("Branch/AddBranch", data: parameter.toJson());

      if (response.statusCode == 200) {
        return true;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      if (error.response?.data case {'errors': List<dynamic> errors}) {
        throw RequestException(errors.firstOrNull);
      }
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }
}
