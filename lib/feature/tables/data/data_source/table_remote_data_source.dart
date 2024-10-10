import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/feature/dashboard/data/models/params/merchant_branch_parameter.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../core/utils/exceptions.dart';
import '../models/params/add_table_parameter.dart';
import '../models/params/delete_table_parameter.dart';
import '../models/params/edit_table_parameter.dart';
import '../models/responese/table_response.dart';

abstract class ITableRemoteDataSource {
  Future<TableResponse> getAllTables([MerchantBranchParameter? parameter]);
  Future<bool> addTable(AddTableParameter parameter);
  Future<bool> editTable(EditTableParameter parameter);

  Future<bool> deleteTable(DeleteTableParameter parameter);
}

@LazySingleton(as: ITableRemoteDataSource)
class TableRemoteDataSource extends ITableRemoteDataSource {
  final Dio _dioClient;

  TableRemoteDataSource(this._dioClient);

  @override
  Future<TableResponse> getAllTables([MerchantBranchParameter? parameter]) async {
    try {
      final Response response = await _dioClient.get("Table/GetAllBranchTables",
          queryParameters: (parameter ?? MerchantBranchParameter()).branchToJson());

      if (response.statusCode == 200) {
        final TableResponse stockResponse = TableResponse.fromJson(response.data);
        return stockResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<bool> addTable(AddTableParameter parameter) async {
    try {
      final Response response = await _dioClient.post("Table/Create", data: parameter.toJson());

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
  Future<bool> editTable(EditTableParameter parameter) async {
    try {
      final Response response = await _dioClient.patch("Table/Edit", data: parameter.toJson());

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
  Future<bool> deleteTable(DeleteTableParameter parameter) async {
    try {
      final Response response = await _dioClient.delete("Table/Delete", queryParameters: parameter.toJson());

      if (response.statusCode == 204) {
        return true;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }
}
