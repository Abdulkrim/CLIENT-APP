import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/core/utils/failure.dart';
import 'package:merchant_dashboard/feature/tables/data/data_source/table_remote_data_source.dart';
import 'package:merchant_dashboard/feature/tables/data/models/params/add_table_parameter.dart';
import 'package:merchant_dashboard/feature/tables/data/models/params/delete_table_parameter.dart';
import 'package:merchant_dashboard/feature/tables/data/models/params/edit_table_parameter.dart';

import '../../../../core/utils/exceptions.dart';
import '../models/entity/table.dart';

abstract class ITableRepository {
  Future<Either<Failure, List<Table>>> getTables();

  Future<Either<Failure, bool>> deleteTable(int tableId);

  Future<Either<Failure, bool>> addTable(
      {required String tableName, required String tableNumber, required String tableCapacity});

  Future<Either<Failure, bool>> editTable(
      {required int tableId,
      required String tableName,
      required String tableNumber,
      required String tableCapacity});
}

@LazySingleton(as: ITableRepository)
class TableRepository extends ITableRepository {
  final ITableRemoteDataSource _tableRemoteDataSource;

  TableRepository(this._tableRemoteDataSource);

  @override
  Future<Either<Failure, List<Table>>> getTables() async {
    try {
      final response = await _tableRemoteDataSource.getAllTables();

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, bool>> addTable(
      {required String tableName, required String tableNumber, required String tableCapacity}) async {
    try {
      final response = await _tableRemoteDataSource.addTable(
          AddTableParameter(tableCapacity: tableCapacity, tableName: tableName, tableNumber: tableNumber));

      return Right(response);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, bool>> editTable(
      {required int tableId,
      required String tableName,
      required String tableNumber,
      required String tableCapacity}) async {
    try {
      final response = await _tableRemoteDataSource.editTable(EditTableParameter(
          tableId: tableId, tableCapacity: tableCapacity, tableName: tableName, tableNumber: tableNumber));

      return Right(response);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteTable(int tableId) async {
    try {
      final response = await _tableRemoteDataSource.deleteTable(DeleteTableParameter(tableId: tableId));

      return Right(response);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }
}
