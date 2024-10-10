import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/core/utils/failure.dart';
import 'package:merchant_dashboard/feature/area_management/data/data_source/area_management_remote_datasource.dart';
import 'package:merchant_dashboard/feature/area_management/data/models/entity/area_details.dart';
import 'package:merchant_dashboard/feature/area_management/data/models/entity/area_item.dart';
import 'package:merchant_dashboard/feature/area_management/data/models/params/create_area_parameter.dart';
import 'package:merchant_dashboard/feature/area_management/data/models/params/delete_area_parameter.dart';
import 'package:merchant_dashboard/feature/area_management/data/models/params/edit_area_parameter.dart';
import 'package:merchant_dashboard/feature/dashboard/data/models/params/merchant_branch_parameter.dart';

import '../../../../core/utils/exceptions.dart';

abstract class IAreaManagementRepository {
  Future<Either<Failure, List<AreaDetails>>> getCityAreas(int cityId);

  Future<Either<Failure, List<AreaItem>>> getBranchAreas();

  Future<Either<Failure, AreaItem>> createArea(
      {int? cityId,
      String? cityName,
      String? areaName,
      int? areaId,
      required num minimumOrderAmount,
      required num deliveryFee,
      num? maxDeliveryDiscount});

  Future<Either<Failure, AreaItem>> editArea(
      {required int id, required num minimumOrderAmount, required num deliveryFee, num? maxDeliveryDiscount});

  Future<Either<Failure, bool>> deleteArea({required int areaId});
}

@LazySingleton(as: IAreaManagementRepository)
class AreaManagementRepository extends IAreaManagementRepository {
  final IAreaManagementRemoteDataSource _areaManagementRemoteDataSource;

  AreaManagementRepository(this._areaManagementRemoteDataSource);

  @override
  Future<Either<Failure, AreaItem>> createArea(
      {int? cityId,
      String? cityName,
      String? areaName,
      int? areaId,
      required num minimumOrderAmount,
      required num deliveryFee,
      num? maxDeliveryDiscount}) async {
    try {
      final response = await _areaManagementRemoteDataSource.createArea(CreateAreaParameter(
        cityId: cityId,
        areaId: areaId,
        areaName: areaName,
        cityName: cityName,
        maxDeliveryDiscount: maxDeliveryDiscount,
        minimumOrderAmount: minimumOrderAmount,
        deliveryFee: deliveryFee,
      ));

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteArea({required int areaId}) async {
    try {
      final response = await _areaManagementRemoteDataSource.deleteArea(DeleteAreaParameter(areaId: areaId));

      return Right(response);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, AreaItem>> editArea(
      {required int id, required num minimumOrderAmount, required num deliveryFee, num? maxDeliveryDiscount}) async {
    try {
      final response = await _areaManagementRemoteDataSource
          .editArea(EditAreaParameter(areaId: id, minimumOrderAmount: minimumOrderAmount, deliveryFee: deliveryFee , maxDeliveryDiscount: maxDeliveryDiscount));

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, List<AreaItem>>> getBranchAreas() async {
    try {
      final response = await _areaManagementRemoteDataSource.getBranchAreas(MerchantBranchParameter());

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, List<AreaDetails>>> getCityAreas(int cityId) async {
    try {
      final response = await _areaManagementRemoteDataSource.getCityAreas(cityId);

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }
}
