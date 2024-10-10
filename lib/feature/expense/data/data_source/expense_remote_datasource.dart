import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/core/client/parameter/base_filter_parameter.dart';
import 'package:merchant_dashboard/feature/dashboard/data/models/params/merchant_branch_parameter.dart';
import 'package:merchant_dashboard/feature/expense/data/models/responese/expense_amounts_response.dart';
import 'package:merchant_dashboard/feature/expense/data/models/responese/expense_types_response.dart';
import 'package:merchant_dashboard/feature/expense/data/models/responese/expenses_response.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:http_parser/http_parser.dart';

import '../../../../core/utils/exceptions.dart';
import '../models/params/add_expense_parameter.dart';
import '../models/params/add_expense_type_parameter.dart';
import '../models/params/edit_expense_parameter.dart';

abstract class IExpenseRemoteDataSource {
  Future<bool> addExpense(AddExpenseParameter parameter);

  Future<bool> editExpense(EditExpenseParameter parameter);

  Future<bool> deleteExpense(int  expenseId);

  Future<int?> addExpenseType(AddExpenseTypeParameter parameter);

  Future<ExpenseTypesResponse> getExpenseTypes(MerchantBranchParameter? parameter);

  Future<ExpensesResponse> getExpenses(BaseFilterListParameter parameter);

  Future<ExpenseAmountsResponse> getExpenseAmounts(BaseFilterListParameter parameter);
}

@LazySingleton(as: IExpenseRemoteDataSource)
class ExpenseRemoteDataSource extends IExpenseRemoteDataSource {
  final Dio _dioClient;

  ExpenseRemoteDataSource(this._dioClient);

  @override
  Future<bool> addExpense(AddExpenseParameter parameter) async {
    try {
      FormData formData = FormData.fromMap({
        if (parameter.file != null)
          "File": MultipartFile.fromBytes(
            await parameter.file!.readAsBytes(),
            filename: parameter.file!.name,
            contentType: (parameter.file!.platformMimeType != null)
                ? MediaType.parse(parameter.file!.platformMimeType!)
                : MediaType('image', '*'),
          ),
        ...parameter.toJson()
      });

      final Response response = await _dioClient.post("Expense/AddBranchExpense", data: formData);

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
  Future<bool> editExpense(EditExpenseParameter parameter) async {
    try {
      FormData formData = FormData.fromMap({
        if (parameter.file != null)
          "File": MultipartFile.fromBytes(
            await parameter.file!.readAsBytes(),
            filename: parameter.file!.name,
            contentType: (parameter.file!.platformMimeType != null)
                ? MediaType.parse(parameter.file!.platformMimeType!)
                : MediaType('image', '*'),
          ),
        ...parameter.toJson()
      });

      final Response response = await _dioClient.post("Expense/EditBranchExpense", data: formData);

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
  Future<int?> addExpenseType(AddExpenseTypeParameter parameter) async {
    try {
      final Response response = await _dioClient.post("Expense/AddExpenseType", data: parameter.toJson());

      if (response.statusCode == 200) {
      return  int.tryParse(response.data['id']);
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<ExpenseTypesResponse> getExpenseTypes(MerchantBranchParameter? parameter) async {
    try {
      final Response response = await _dioClient.get("Expense/GetExpenseType",
          queryParameters: (parameter ?? MerchantBranchParameter()).businessToJson());

      if (response.statusCode == 200) {
        final ExpenseTypesResponse measureUnitResponse = ExpenseTypesResponse.fromJson(response.data);
        return measureUnitResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<ExpensesResponse> getExpenses(BaseFilterListParameter parameter) async {
    try {
      final Response expResponse = await _dioClient.post("Expense/GetBranchExpenses",
          data: parameter.filterToJson(), queryParameters: parameter.branchToJson());

      if (expResponse.statusCode == 200) {
        final ExpensesResponse response = ExpensesResponse.fromJson(expResponse.data);
        return response;
      }
      throw RequestException(expResponse.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<ExpenseAmountsResponse> getExpenseAmounts(BaseFilterListParameter parameter) async {
    try {
      final Response expResponse = await _dioClient.post("Expense/GetExpenseAmount",
          data: parameter.filterToJson(), queryParameters: parameter.branchToJson());

      if (expResponse.statusCode == 200) {
        final response = ExpenseAmountsResponse.fromJson(expResponse.data);
        return response;
      }
      throw RequestException(expResponse.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<bool> deleteExpense(int expenseId) async {
    try {
      final Response expResponse = await _dioClient.delete("Expense/Delete", queryParameters: {'id': expenseId});

      return expResponse.statusCode == 200;
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }
}
