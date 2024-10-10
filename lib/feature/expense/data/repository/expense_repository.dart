import 'package:either_dart/either.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/core/client/parameter/base_filter_parameter.dart';
import 'package:merchant_dashboard/core/utils/failure.dart';
import 'package:merchant_dashboard/feature/expense/data/data_source/expense_remote_datasource.dart';
import 'package:merchant_dashboard/feature/expense/data/models/entity/expense_amount.dart';
import 'package:merchant_dashboard/feature/expense/data/models/entity/expense_type.dart';
import 'package:merchant_dashboard/feature/expense/data/models/entity/expenses_info.dart';
import 'package:merchant_dashboard/feature/expense/data/models/params/add_expense_parameter.dart';
import 'package:merchant_dashboard/feature/expense/data/models/params/add_expense_type_parameter.dart';

import '../../../../core/constants/defaults.dart';
import '../../../../core/utils/exceptions.dart';
import '../../../../utils/mixins/date_time_utilities.dart';
import '../models/params/edit_expense_parameter.dart';

abstract class IExpenseRepository {
  Future<Either<Failure, int>> addExpenseType(String name);

  Future<Either<Failure, bool>> deleteExpense(int expenseId);

  Future<Either<Failure, List<ExpenseType>>> getExpenseTypes();

  Future<Either<Failure, List<ExpenseAmount>>> getExpenseAmounts();

  Future<Either<Failure, ExpensesInfo>> getExpenses({
    int? expenseTypeId,
    int? paymentModeId,
    String? searchText,
    required String fromDate,
    required String toDate,
    required int currentPage,
  });

  Future<Either<Failure, bool>> addExpense({
    required int expenseTypeId,
    required int paymentModeId,
    required String amount,
    required String date,
    required String note,
    required XFile? file,
  });

  Future<Either<Failure, bool>> editExpense({
    required int expenseId,
    required int expenseTypeId,
    required int paymentModeId,
    required String amount,
    required String date,
    required String note,
    required XFile? file,
  });
}

@LazySingleton(as: IExpenseRepository)
class ExpenseRepository extends IExpenseRepository with DateTimeUtilities {
  final IExpenseRemoteDataSource _expenseRemoteDataSource;

  ExpenseRepository(this._expenseRemoteDataSource);

  @override
  Future<Either<Failure, bool>> addExpense(
      {required int expenseTypeId,
      required int paymentModeId,
      required String amount,
      required String date,
      required String note,
      required XFile? file}) async {
    try {
      final bool response = await _expenseRemoteDataSource.addExpense(AddExpenseParameter(
          date: date, expenseTypeId: expenseTypeId, amount: amount, file: file, note: note, pementModeId: paymentModeId));

      return Right(response);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, bool>> editExpense(
      {required int expenseId,
      required int expenseTypeId,
      required int paymentModeId,
      required String amount,
      required String date,
      required String note,
      required XFile? file}) async {
    try {
      final bool response = await _expenseRemoteDataSource.editExpense(EditExpenseParameter(
          expenseId: expenseId,
          date: date,
          expenseTypeId: expenseTypeId,
          amount: amount,
          file: file,
          note: note,
          pementModeId: paymentModeId));

      return Right(response);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, int>> addExpenseType(String name) async {
    try {
      final int? response = await _expenseRemoteDataSource.addExpenseType(AddExpenseTypeParameter(name: name));

      return response == null ? Left(RequestError('Something went wrong.')) : Right(response);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, List<ExpenseType>>> getExpenseTypes() async {
    try {
      final response = await _expenseRemoteDataSource.getExpenseTypes(null);

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, ExpensesInfo>> getExpenses({
    int? expenseTypeId,
    int? paymentModeId,
    String? searchText,
    required String fromDate,
    required String toDate,
    required int currentPage,
  }) async {
    try {
      List<BaseFilterInfoParameter> filterInfo = [];

      if (fromDate.isNotEmpty && toDate.isNotEmpty) {
        filterInfo.add(BaseFilterInfoParameter(
            propertyName: 'date',
            value: getFilterFormatDate(fromDate),
            operator: QueryOperator.greaterThanOrEqualTo.value,
            logical: LogicalOperator.and.value));

        filterInfo.add(BaseFilterInfoParameter(
            propertyName: 'date',
            value: getFilterFormatDate(toDate),
            operator: QueryOperator.lessThanOrEqualTo.value,
            logical: LogicalOperator.and.value));
      }

      if (expenseTypeId != null && expenseTypeId != 0) {
        filterInfo.add(BaseFilterInfoParameter(
            propertyName: 'expenseTypeId',
            value: expenseTypeId.toString(),
            operator: QueryOperator.equals.value,
            logical: LogicalOperator.and.value));
      }
      if (paymentModeId != null && paymentModeId != 0) {
        filterInfo.add(BaseFilterInfoParameter(
            propertyName: 'paymentModeId',
            value: paymentModeId.toString(),
            operator: QueryOperator.equals.value,
            logical: LogicalOperator.and.value));
      }
      if (searchText != null && searchText.isNotEmpty) {
        filterInfo.addAll([
          BaseFilterInfoParameter(
              logical: LogicalOperator.and.value,
              operator: QueryOperator.contains.value,
              propertyName: 'expenseTypeName',
              value: searchText),
          BaseFilterInfoParameter(
              logical: LogicalOperator.or.value, operator: QueryOperator.contains.value, propertyName: 'note', value: searchText),
          if (searchText.isNum)
            BaseFilterInfoParameter(
                logical: LogicalOperator.or.value,
                operator: QueryOperator.equals.value,
                propertyName: 'amount',
                value: searchText)
        ]);
      }

      final response =
          await _expenseRemoteDataSource.getExpenses(BaseFilterListParameter(filterInfo: filterInfo, page: currentPage));

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, List<ExpenseAmount>>> getExpenseAmounts() async {
    try {
      final response = await _expenseRemoteDataSource.getExpenseAmounts(BaseFilterListParameter(page: -1, count: 0, filterInfo: [
        BaseFilterInfoParameter(
            logical: LogicalOperator.and.value, operator: QueryOperator.startsWith.value, propertyName: 'amount', value: '1')
      ]));

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteExpense(int expenseId) async {
    try {
      final response = await _expenseRemoteDataSource.deleteExpense(expenseId);

      return Right(response);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }
}
