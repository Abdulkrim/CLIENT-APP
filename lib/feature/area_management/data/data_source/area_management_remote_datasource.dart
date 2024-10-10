import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/feature/area_management/data/models/responses/city_areas_response.dart';
import 'package:merchant_dashboard/feature/area_management/data/models/responses/areas_response.dart';
import 'package:merchant_dashboard/feature/dashboard/data/models/params/merchant_branch_parameter.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../core/utils/exceptions.dart';
import '../models/params/create_area_parameter.dart';
import '../models/params/delete_area_parameter.dart';
import '../models/params/edit_area_parameter.dart';

abstract class IAreaManagementRemoteDataSource {
  Future<CityAreasResponse> getCityAreas(int cityId);

  Future<AreasResponse> getBranchAreas(MerchantBranchParameter parameter);

  Future<AreaItemResponse> createArea(CreateAreaParameter parameter);

  Future<AreaItemResponse> editArea(EditAreaParameter parameter);

  Future<bool> deleteArea(DeleteAreaParameter parameter);
}

@LazySingleton(as: IAreaManagementRemoteDataSource)
class AreaManagementRemoteDataSource extends IAreaManagementRemoteDataSource {
  final Dio _dioClient;

  AreaManagementRemoteDataSource(this._dioClient);

  @override
  Future<AreaItemResponse> createArea(CreateAreaParameter parameter) async {
    try {
      final Response response = await _dioClient.post("Area/Create", data: parameter.toJson());

      if (response.statusCode == 200) {
        return AreaItemResponse.fromJson(response.data);
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<bool> deleteArea(DeleteAreaParameter parameter) async {
    try {
      final Response response = await _dioClient.delete("Area/Delete", queryParameters: parameter.toJson());

      if (response.statusCode == 204) {
        return true;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<AreaItemResponse> editArea(EditAreaParameter parameter) async {
    try {
      final Response response = await _dioClient.patch("Area/Edit", data: parameter.toJson());

      if (response.statusCode == 200) {
        return AreaItemResponse.fromJson(response.data);
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<AreasResponse> getBranchAreas(MerchantBranchParameter parameter) async {
    try {
      final Response response = await _dioClient.get("Area/BranchAreas", queryParameters: parameter.branchToJson());

      if (response.statusCode == 200) {
        return AreasResponse.fromJson(response.data);
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<CityAreasResponse> getCityAreas(int cityId) async {
    try {
      final Response response = await _dioClient.get("Area/CityAreas", queryParameters: {'cityId': cityId});

      if (response.statusCode == 200) {
        return CityAreasResponse.fromJson(response.data);
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }
}
