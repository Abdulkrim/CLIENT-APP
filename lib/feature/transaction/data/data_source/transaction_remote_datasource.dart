import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/core/utils/exceptions.dart';
import 'package:merchant_dashboard/feature/transaction/data/models/params/claim_transaction_parameter.dart';
import 'package:merchant_dashboard/feature/transaction/data/models/response/transactions_response.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../core/client/parameter/base_filter_parameter.dart';
import '../../../../core/client/request_cancel_token.dart';
import '../../../../core/constants/defaults.dart';
import '../models/params/transaction_details_parameter.dart';
import '../models/response/transaction_details_response.dart';

abstract class ITransactionRemoteDataSource {
  Future<TransactionsResponse> getAllTransactions(BaseFilterListParameter filterBodyParameter);

  Future<TransactionDetailsDataResponse> getTransactionDetails(TransactionDetailsParameter parameter);

  Future<bool> claimAllTransaction(ClaimTransactionParameter claimTransactionParameter);

  Future<bool> claimPartialTransaction(ClaimTransactionParameter claimTransactionParameter);

  Future<String> getDownloadExcelLink(BaseFilterListParameter parameter);

  Future<TransactionsResponse> getCustomerTransactions(
      BaseFilterListParameter filterBodyParameter, String customerId);
}

@LazySingleton(as: ITransactionRemoteDataSource)
class TransactionRemoteDataSource extends ITransactionRemoteDataSource with RequestCancelToken {
  final Dio _dioClient;

  TransactionRemoteDataSource(this._dioClient);

  final Map<String, CancelToken> _cancelTokens = {};

  CancelToken _getCancelToken(String apiName) {
    final cancelToken =
        _cancelTokens.containsKey(apiName) ? cancelRequest(_cancelTokens[apiName]!) : CancelToken();

    _cancelTokens[apiName] = cancelToken;
    return cancelToken;
  }

  @override
  Future<TransactionsResponse> getAllTransactions(BaseFilterListParameter filterBodyParameter) async {
    try {
      final cancelToken = _getCancelToken('GetTransactionsByFilter${filterBodyParameter.count}');
      final Response response = await _dioClient.post("Transaction/GetTransactionsByFilter",
          cancelToken: cancelToken, data: filterBodyParameter.filterToJson());

      if (response.statusCode == 200) {
        final TransactionsResponse transactionsResponse = TransactionsResponse.fromJson(response.data);

        return transactionsResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      if (error.message == Defaults.canceledRequest) {
        throw const RequestException("Force canceled");
      }
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<TransactionsResponse> getCustomerTransactions(
      BaseFilterListParameter filterBodyParameter, String customerId) async {
    try {
      final cancelToken = getCancelToken('GetTransactionsByCustomer');
      final Response response = await _dioClient.post("Transaction/GetTransactionsByCustomer",
          data: filterBodyParameter.filterToJson(),
          queryParameters: {'customerId': customerId},
          cancelToken: cancelToken);

      if (response.statusCode == 200) {
        final TransactionsResponse transactionsResponse = TransactionsResponse.fromJson(response.data);

        return transactionsResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      if (error.message == Defaults.canceledRequest) {
        throw const RequestException("Force canceled");
      }
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<TransactionDetailsDataResponse> getTransactionDetails(TransactionDetailsParameter parameter) async {
    try {
      final cancelToken = _getCancelToken('GetTransactionDetails');

      final Response response = await _dioClient.get("Transaction/GetTransactionDetails",
          cancelToken: cancelToken, queryParameters: parameter.toJson());

      if (response.statusCode == 200) {
        final TransactionDetailsDataResponse transactionsResponse =
            TransactionDetailsDataResponse.fromJson(response.data);

        return transactionsResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      if (error.message == Defaults.canceledRequest) {
        throw const RequestException("Force canceled");
      }
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<bool> claimAllTransaction(ClaimTransactionParameter claimTransactionParameter) async {
    try {
      final Response response = await _dioClient.post("Transaction/ClaimTransaction",
          queryParameters: {'transactionId': claimTransactionParameter.transactionMasterId});

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
  Future<bool> claimPartialTransaction(ClaimTransactionParameter claimTransactionParameter) async {
    try {
      final Response response =
          await _dioClient.post("Transaction/claim", data: claimTransactionParameter.toJson());

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
  Future<String> getDownloadExcelLink(BaseFilterListParameter parameter) async {
    try {
      final Response response =
          await _dioClient.post("Transaction/DownloadTransactionsByFilter", data: parameter.filterToJson());

      if (response.statusCode == 200) {
        return response.data.toString();
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }
}
