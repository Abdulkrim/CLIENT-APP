import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/feature/business_hours/data/models/responese/branch_time_shifts_response.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../core/client/request_cancel_token.dart';
import '../../../../core/utils/exceptions.dart';
import '../models/params/create_exception_shift_parameter.dart';
import '../models/params/get_branch_shift_parameter.dart';
import '../models/params/manage_work_type_shift_parameter.dart';

abstract class IBranchRemoteDataSource {
  Future<BranchTimeShiftListResponse> getBranchShifts(GetBranchShiftParameter parameter);

  Future<bool> manageWorkTypeShiftTimes(ManageWorkTypeShiftParameter parameter);

  Future<bool> createExceptionShift(CreateExceptionShiftParameter parameter);
}

@LazySingleton(as: IBranchRemoteDataSource)
class BranchRemoteDataSource extends IBranchRemoteDataSource with RequestCancelToken {
  final Dio _dioClient;

  BranchRemoteDataSource(this._dioClient);

  @override
  Future<BranchTimeShiftListResponse> getBranchShifts(GetBranchShiftParameter parameter) async {
    try {
      cancelAllRequests();

      final cancelToken = getCancelToken('BranchShift/Get');

      final Response response = await _dioClient.get("BranchShift/Get",
          queryParameters: parameter.toJson(), cancelToken: cancelToken);

      if (response.statusCode == 200) {
        return BranchTimeShiftListResponse.fromJson(response.data);
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<bool> manageWorkTypeShiftTimes(ManageWorkTypeShiftParameter parameter) async {
    try {
        final Response response = await _dioClient.put("BranchShift/Manage", data: parameter.toJson());

      if (response.statusCode == 201) {
        return true;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<bool> createExceptionShift(CreateExceptionShiftParameter parameter) async {
    try {
      final Response response =
          await _dioClient.post("BranchShift/CreateExceptionHours", data: parameter.toJson());

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
