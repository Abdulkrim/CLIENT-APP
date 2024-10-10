import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/core/client/parameter/base_filter_parameter.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../core/utils/exceptions.dart';
import '../models/params/add_worker_parameter.dart';
import '../models/params/edit_worker_parameter.dart';
import '../models/response/workers_response.dart';

abstract class IWorkerRemoteDataSource {
  Future<WorkersResponse> getAllWorkerBySales(BaseFilterListParameter parameter, bool isAscending);

  Future<WorkersResponse> getAllWorkers(BaseFilterListParameter parameter);

  Future<bool> addWorker(AddWorkerParameter parameter);

  Future<bool> editWorker(EditWorkerParameter parameter);
}

@LazySingleton(as: IWorkerRemoteDataSource)
class WorkerRemoteDataSource extends IWorkerRemoteDataSource {
  final Dio _dioClient;

  WorkerRemoteDataSource(this._dioClient);

  @override
  Future<WorkersResponse> getAllWorkers(BaseFilterListParameter parameter) async {
    try {
      final Response response = await _dioClient.post("Worker/GetWorkersByFilter", data: parameter.filterToJson());

      if (response.statusCode == 200) {
        final WorkersResponse cashiersResponse = WorkersResponse.fromJson(response.data);
        return cashiersResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<bool> addWorker(AddWorkerParameter parameter) async {
    try {
      final Response response = await _dioClient.post("Worker/Create", data: parameter.toJson());

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
  Future<bool> editWorker(EditWorkerParameter parameter) async {
    try {
      final Response response = await _dioClient.patch("Worker/Edit", data: parameter.toJson());

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
  Future<WorkersResponse> getAllWorkerBySales(BaseFilterListParameter parameter, bool isAscending) async {
    try {
      final Response response = await _dioClient.post("Worker/GetSalesByWorker?sortAscending=$isAscending",
          data: parameter.filterToJson());

      if (response.statusCode == 200) {
        final res = WorkersResponse.fromJson(response.data);
        return res;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }
}
