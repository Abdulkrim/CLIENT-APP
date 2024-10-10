import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/core/client/parameter/base_filter_parameter.dart';
import 'package:merchant_dashboard/core/utils/failure.dart';

import '../../../../core/constants/defaults.dart';
import '../../../../core/utils/exceptions.dart';
import '../../../../utils/mixins/date_time_utilities.dart';
import '../data_source/worker_remote_datasource.dart';
import '../models/entity/worker_list_info.dart';
import '../models/params/add_worker_parameter.dart';
import '../models/params/edit_worker_parameter.dart';
import '../models/response/workers_response.dart';

abstract class IWorkerRepository {
  Future<Either<Failure, WorkerListInfo>> getAllWorkerSales(
      {required int currentPage,
      required String fromDate,
      required String toDate,
      required String orderType,
      required String orderField});

  Future<Either<Failure, WorkerListInfo>> getAllWorkers(int currentPage);

  Future<Either<Failure, bool>> addWorker({required String fullName});

  Future<Either<Failure, bool>> editWorker(
      {required String workerId, required String fullName, required bool isActive});
}

@LazySingleton(as: IWorkerRepository)
class WorkerRepository extends IWorkerRepository with DateTimeUtilities {
  final IWorkerRemoteDataSource _workerRemoteDataSource;

  WorkerRepository(this._workerRemoteDataSource);

  @override
  Future<Either<Failure, bool>> addWorker({required String fullName}) async {
    try {
      final bool response = await _workerRemoteDataSource.addWorker(AddWorkerParameter(fullName: fullName));

      return Right(response);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, bool>> editWorker(
      {required String workerId, required String fullName, required bool isActive}) async {
    try {
      final bool response = await _workerRemoteDataSource
          .editWorker(EditWorkerParameter(fullName: fullName, workerId: workerId, isActive: isActive));

      return Right(response);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, WorkerListInfo>> getAllWorkers(int currentPage) async {
    try {
      final WorkersResponse response =
          await _workerRemoteDataSource.getAllWorkers(BaseFilterListParameter(page: currentPage));

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, WorkerListInfo>> getAllWorkerSales(
      {required int currentPage,
      required String fromDate,
      required String toDate,
      required String orderType,
      required String orderField}) async {
    try {
      final BaseFilterListParameter cashierListParameter = BaseFilterListParameter(filterInfo: [
        BaseFilterInfoParameter(
          propertyName: 'FromDate',
          value: getFilterFormatDate(fromDate),
          operator: QueryOperator.greaterThanOrEqualTo.value,
          logical: LogicalOperator.and.value,
        ),
        BaseFilterInfoParameter(
          propertyName: 'ToDate',
          value: getFilterFormatDate(toDate),
          operator: QueryOperator.lessThanOrEqualTo.value,
          logical: LogicalOperator.and.value,
        )
      ], page: currentPage);

      final response = await _workerRemoteDataSource.getAllWorkerBySales(
          cashierListParameter, orderType == Defaults.sortTypeASC);

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }
}
