import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/core/utils/exceptions.dart';
import 'package:merchant_dashboard/core/utils/failure.dart';
import 'package:merchant_dashboard/feature/cashiers/data/data_source/cashier_remote_datasource.dart';
import 'package:merchant_dashboard/feature/cashiers/data/models/entity/cashier.dart';
import 'package:merchant_dashboard/feature/cashiers/data/models/entity/cashier_role.dart';
import 'package:merchant_dashboard/feature/cashiers/data/models/params/add_cashier_parameter.dart';
import 'package:merchant_dashboard/feature/cashiers/data/models/params/delete_cashier_parameter.dart';
import 'package:merchant_dashboard/feature/cashiers/data/models/params/edit_cashier_parameter.dart';
import 'package:merchant_dashboard/feature/cashiers/data/models/response/cashier_roles_response.dart';
import 'package:merchant_dashboard/feature/cashiers/data/models/response/cashiers_response.dart';
import 'package:merchant_dashboard/utils/mixins/date_time_utilities.dart';

import '../../../../core/client/parameter/base_filter_parameter.dart';
import '../../../../core/constants/defaults.dart';
import '../models/params/get_cashiers_parameter.dart';
import '../models/response/cashier_summerized_response.dart';

abstract class ICashierRepository {
  Future<Either<Failure, CashierListInfo>> getAllCashiersOnce({bool onlyActiveItems = false});

  Future<Either<Failure, CashierListInfo>> getAllCashiers({required int currentPage});

  Future<Either<Failure, CashierListInfo>> getAllFilteredCashiers(
      {required int currentPage,
      required String fromDate,
      required String toDate,
      required String orderType,
      required String orderField});

  Future<Either<Failure, List<CashierRole>>> getCashierRoles();

  Future<Either<Failure, bool>> deleteCashier(int cashierId);

  Future<Either<Failure, bool>> addCashier(String name, String password, int roleId);

  Future<Either<Failure, bool>> editCashier(String cashierId, String name, int roleId, bool status);
}

@LazySingleton(as: ICashierRepository)
class CashierRepository extends ICashierRepository with DateTimeUtilities {
  final ICashierRemoteDataSource _cashierRemoteDataSource;

  CashierRepository(this._cashierRemoteDataSource);

  @override
  Future<Either<Failure, CashierListInfo>> getAllCashiersOnce({bool onlyActiveItems = false}) async {
    try {
      final CashierSummerizedResponse response = await _cashierRemoteDataSource
          .getAllCashiersOnce(GetCashiersParameter(isOnlyActiveItems: onlyActiveItems));

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, CashierListInfo>> getAllCashiers({required int currentPage}) async {
    try {
      final BaseFilterListParameter cashierListParameter = BaseFilterListParameter(page: currentPage);

      final CashiersResponse response = await _cashierRemoteDataSource.getAllCashiers(cashierListParameter);

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, CashierListInfo>> getAllFilteredCashiers(
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

      final CashiersResponse response = await _cashierRemoteDataSource.getFilteredCashier(
          cashierListParameter, orderType == Defaults.sortTypeASC);

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, bool>> addCashier(String name, String password, int roleId) async {
    try {
      final bool response = await _cashierRemoteDataSource
          .addCashier(AddCashierParameter(name: name, password: password, roleId: roleId));

      return Right(response);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteCashier(int cashierId) async {
    try {
      final bool response =
          await _cashierRemoteDataSource.deleteCashier(DeleteCashierParameter(id: cashierId));

      return Right(response);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, List<CashierRole>>> getCashierRoles() async {
    try {
      final CashierRolesResponse response = await _cashierRemoteDataSource.getCashierRoles();

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, bool>> editCashier(String cashierId, String name, int roleId, bool status) async {
    try {
      final bool response = await _cashierRemoteDataSource
          .editCashier(EditCashierParameter(id: cashierId, name: name, roleId: roleId, status: status));

      return Right(response);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }
}
