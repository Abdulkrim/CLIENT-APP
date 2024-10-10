import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/core/constants/defaults.dart';
import 'package:merchant_dashboard/core/utils/exceptions.dart';
import 'package:merchant_dashboard/core/utils/failure.dart';
import 'package:merchant_dashboard/feature/dashboard/data/models/params/dashboard_data_parameter.dart';
import 'package:merchant_dashboard/feature/transaction/data/data_source/transaction_remote_datasource.dart';
import 'package:merchant_dashboard/feature/transaction/data/models/entity/transaction.dart';
import 'package:merchant_dashboard/feature/transaction/data/models/params/claim_transaction_parameter.dart';
import 'package:merchant_dashboard/feature/transaction/data/models/params/transaction_details_parameter.dart';
import 'package:merchant_dashboard/feature/transaction/data/models/response/transactions_response.dart';

import '../../../../core/client/parameter/base_filter_parameter.dart';
import '../../../../utils/mixins/date_time_utilities.dart';
import '../../../orders/data/models/response/top_last/top_last_orders_response.dart';
import '../models/entity/transaction_details.dart';

abstract class ITransactionRepository {
  Future<Either<Failure, TransactionListInfo>> getAllCustomerTransaction(String customerId, int currentPage);

  Future<Either<Failure, TransactionListInfo>> getAllTransaction(
      {int? categoryId,
      int? subCategoryId,
      int? productId,
      String? cashierId,
      String? fromDate,
      String? toDate,
      String? startTime,
      String? endTime,
      int itemCount = 25,
      int orderType = 2,
      String orderProperty = "TransactionDateTime",
      required int currentPage});


  Future<Either<Failure, bool>> claimTransaction(int transactionId, [List<int>? detailsId]);

  Future<Either<Failure, List<TransactionDetails>>> getTransactionDetails(int transactionId);

  Future<Either<Failure, String>> getDownloadExcelLink(
      {int? categoryId, int? productId, String? cashierId, String? fromDate, String? toDate, required int currentPage});
}

@LazySingleton(as: ITransactionRepository)
class TransactionRepository extends ITransactionRepository with DateTimeUtilities {
  final ITransactionRemoteDataSource _transactionRemoteDataSource;

  TransactionRepository(this._transactionRemoteDataSource);

  @override
  Future<Either<Failure, TransactionListInfo>> getAllCustomerTransaction(String customerId, int currentPage) async {
    try {
      final TransactionsResponse response = await _transactionRemoteDataSource.getCustomerTransactions(
          BaseFilterListParameter(page: currentPage, filterInfo: [
            BaseFilterInfoParameter(
              logical: LogicalOperator.and.value,
              operator: QueryOperator.equals.value,
              value: "1",
              propertyName: 'TransactionType',
            )
          ]),
          customerId);

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, TransactionListInfo>> getAllTransaction(
      {int? categoryId,
      int? subCategoryId,
      int? productId,
      String? cashierId,
        String? startTime,
        String? endTime,
      int itemCount = 25,
      String? fromDate,
      String? toDate,
      int orderType = 2,
      String orderProperty = "TransactionDateTime",
      required int currentPage}) async {
    try {
      List<BaseFilterInfoParameter> filterInfo = [];

      if (categoryId != null && categoryId != 0) {
        filterInfo.add(BaseFilterInfoParameter(
            propertyName: 'categoryId',
            value: categoryId.toString(),
            operator: QueryOperator.equals.value,
            logical: LogicalOperator.and.value));
      }
      if (subCategoryId != null && subCategoryId != 0) {
        filterInfo.add(BaseFilterInfoParameter(
            propertyName: 'subCategoryId',
            value: subCategoryId.toString(),
            operator: QueryOperator.equals.value,
            logical: LogicalOperator.and.value));
      }
      if (productId != null && productId != 0) {
        filterInfo.add(BaseFilterInfoParameter(
            propertyName: 'productId',
            value: productId.toString(),
            operator: QueryOperator.equals.value,
            logical: LogicalOperator.and.value));
      }
      if (cashierId != null && cashierId != '0') {
        filterInfo.add(BaseFilterInfoParameter(
            propertyName: 'cashierId',
            value: cashierId,
            operator: QueryOperator.equals.value,
            logical: LogicalOperator.and.value));
      }
      if (fromDate != null && fromDate.isNotEmpty && toDate != null && toDate.isNotEmpty) {
        filterInfo.add(BaseFilterInfoParameter(
            propertyName: 'FromDate',
            value: getFilterFormatDate(fromDate),
            operator: QueryOperator.greaterThanOrEqualTo.value,
            logical: LogicalOperator.and.value));
        filterInfo.add(BaseFilterInfoParameter(
            propertyName: 'ToDate',
            value: getFilterFormatDate(toDate),
            operator: QueryOperator.lessThanOrEqualTo.value,
            logical: LogicalOperator.and.value));
      }

      if (startTime != null && startTime.isNotEmpty && endTime != null && endTime.isNotEmpty) {
        filterInfo.add(BaseFilterInfoParameter(
            propertyName: 'FromTime',
            value: convertTo24Hour(startTime),
            operator: QueryOperator.greaterThanOrEqualTo.value,
            logical: LogicalOperator.and.value));
        filterInfo.add(BaseFilterInfoParameter(
            propertyName: 'toTime',
            value: convertTo24Hour(endTime),
            operator: QueryOperator.lessThanOrEqualTo.value,
            logical: LogicalOperator.and.value));
      }

     final parameter =  BaseFilterListParameter(
        page: currentPage,
        count: itemCount,
        orderInfo: [BaseSortInfoParameter(orderType: orderType, property: orderProperty)],
        filterInfo: [
          ...filterInfo,
          BaseFilterInfoParameter(
            logical: LogicalOperator.and.value,
            operator: QueryOperator.equals.value,
            value: "1",
            propertyName: 'TransactionType',
          )
        ],
      );
      final TransactionsResponse response = await _transactionRemoteDataSource.getAllTransactions(parameter);

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }
  @override
  Future<Either<Failure, String>> getDownloadExcelLink(
      {int? categoryId, int? productId, String? cashierId, String? fromDate, String? toDate, required int currentPage}) async {
    try {
      List<BaseFilterInfoParameter> filterInfo = [];

      if (categoryId != null && categoryId != 0) {
        filterInfo.add(BaseFilterInfoParameter(
            propertyName: 'categoryId',
            value: categoryId.toString(),
            operator: QueryOperator.equals.value,
            logical: LogicalOperator.and.value));
      }
      if (productId != null && productId != 0) {
        filterInfo.add(BaseFilterInfoParameter(
            propertyName: 'productId',
            value: productId.toString(),
            operator: QueryOperator.equals.value,
            logical: LogicalOperator.and.value));
      }
      if (cashierId != null && cashierId != '0') {
        filterInfo.add(BaseFilterInfoParameter(
            propertyName: 'cashierId',
            value: cashierId,
            operator: QueryOperator.equals.value,
            logical: LogicalOperator.and.value));
      }
      if (fromDate != null && fromDate.isNotEmpty && toDate != null && toDate.isNotEmpty) {
        filterInfo.add(BaseFilterInfoParameter(
            propertyName: 'FromDate',
            value: getFilterFormatDate(fromDate),
            operator: QueryOperator.greaterThanOrEqualTo.value,
            logical: LogicalOperator.and.value));
        filterInfo.add(BaseFilterInfoParameter(
            propertyName: 'ToDate',
            value: getFilterFormatDate(toDate),
            operator: QueryOperator.lessThanOrEqualTo.value,
            logical: LogicalOperator.and.value));
      }


      final parameter =  BaseFilterListParameter(
        page: -1,
        count: 0,
        filterInfo: [
          ...filterInfo,
          BaseFilterInfoParameter(
            logical: LogicalOperator.and.value,
            operator: QueryOperator.equals.value,
            value: "1",
            propertyName: 'TransactionType',
          )
        ],
      );


      final String response = await _transactionRemoteDataSource.getDownloadExcelLink(parameter);

      return Right(response);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, bool>> claimTransaction(int transactionId, [List<int>? detailsId]) async {
    try {
      bool response = false;

      if (detailsId != null) {
        response = await _transactionRemoteDataSource.claimPartialTransaction(
            ClaimTransactionParameter(transactionMasterId: transactionId, transactionDetailsIds: detailsId));
      } else {
        response =
            await _transactionRemoteDataSource.claimAllTransaction(ClaimTransactionParameter(transactionMasterId: transactionId));
      }

      return Right(response);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, List<TransactionDetails>>> getTransactionDetails(int transactionId) async {
    try {
      final response = await _transactionRemoteDataSource
          .getTransactionDetails(TransactionDetailsParameter(transactionMasterId: transactionId));

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }
}
