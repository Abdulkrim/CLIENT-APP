import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/feature/customers/data/models/params/create_customer_payment_parameter.dart';
import 'package:merchant_dashboard/feature/customers/data/models/params/customer_parameter.dart';
import 'package:merchant_dashboard/feature/customers/data/models/response/info/customers_response.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../core/client/request_cancel_token.dart';
import '../../../../core/constants/defaults.dart';
import '../../../../core/utils/exceptions.dart';
import '../../../../core/client/parameter/base_filter_parameter.dart';
import '../models/params/customer_credit_histories_parameter.dart';
import '../models/response/credit_history/credit_histories_response.dart';
import '../models/response/orders/customer_orders_response.dart';

abstract class ICustomerRemoteDataSource {
  Future<bool> addCustomer(CustomerParameter customerParameter);

  Future<bool> editCustomer(CustomerParameter customerParameter);

  Future<bool> deleteCustomer(String customerId);

  Future<CustomersResponse> getAllCustomers(BaseFilterListParameter parameter);

  Future<CustomerInfoResponse> getSpecificCustomer(String phoneNumber);

  Future<CustomerInfoResponse> getCustomerDetails(String customerId);

  Future<CustomerOrdersResponse> getCustomerOrders(BaseFilterListParameter filterBodyParameter, String customerId);

  Future<bool> createCustomerPayment(CreateCustomerPaymentParameter parameter);

  Future<CreditHistoriesResponse> getCustomerCreditHistories(CustomerCreditHistoriesParameter parameter);
}

@LazySingleton(as: ICustomerRemoteDataSource)
class CustomerRemoteDataSource extends ICustomerRemoteDataSource with RequestCancelToken {
  final Dio _dioClient;

  CustomerRemoteDataSource(this._dioClient);

  @override
  Future<bool> addCustomer(CustomerParameter customerParameter) async {
    try {
      final cancelToken = getCancelToken('Customer/Create');
      final Response response =
          await _dioClient.post("Customer/Create", data: customerParameter.toCreateJson(), cancelToken: cancelToken);

      if (response.statusCode == 201) {
        return true;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      if (error.error == Defaults.canceledRequest) {
        throw const RequestException(Defaults.canceledRequest);
      }
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<bool> editCustomer(CustomerParameter customerParameter) async {
    try {
        final cancelToken = getCancelToken('Customer/Update');
      final Response response =
          await _dioClient.put("Customer/Update", data: customerParameter.toEditJson(), cancelToken: cancelToken);

      if (response.statusCode == 200) {
        return true;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      if (error.error == Defaults.canceledRequest) {
        throw const RequestException(Defaults.canceledRequest);
      }
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<CustomersResponse> getAllCustomers(BaseFilterListParameter parameter) async {
    try {
      cancelAllRequests();
      final cancelToken = getCancelToken('Customer/GetCustomersByFilter');
      final Response response =
          await _dioClient.post("Customer/GetCustomersByFilter", data: parameter.filterToJson(), cancelToken: cancelToken);

      if (response.statusCode == 200) {
        final CustomersResponse res = CustomersResponse.fromJson(response.data);

        return res;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      if (error.error == Defaults.canceledRequest) {
        throw const RequestException(Defaults.canceledRequest);
      }
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<CustomerInfoResponse> getSpecificCustomer(String phoneNumber) async {
    try {
      cancelAllRequests();
      final cancelToken = getCancelToken('GetCustomerByPhoneNumber');
      final Response response = await _dioClient.get("Customer/GetCustomerByPhoneNumber",
          queryParameters: {'phoneNumber': phoneNumber}, cancelToken: cancelToken);

      if (response.statusCode == 200) {
        final CustomerInfoResponse res = CustomerInfoResponse.fromJson(response.data);

        return res;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      if (error.error == Defaults.canceledRequest) {
        throw const RequestException(Defaults.canceledRequest);
      }
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }


  @override
  Future<CustomerInfoResponse> getCustomerDetails(String customerId) async {
    try {
      cancelAllRequests();
      final cancelToken = getCancelToken('Get');
      final Response response = await _dioClient.get("Customer/Get",
          queryParameters: {'customerId': customerId}, cancelToken: cancelToken);

      if (response.statusCode == 200) {
        final CustomerInfoResponse res = CustomerInfoResponse.fromJson(response.data);

        return res;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      if (error.error == Defaults.canceledRequest) {
        throw const RequestException(Defaults.canceledRequest);
      }
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<CustomerOrdersResponse> getCustomerOrders(BaseFilterListParameter filterBodyParameter, String customerId) async {
    try {
      final cancelToken = getCancelToken('GetOrdersByCustomer');
      final Response response = await _dioClient.post("Order/GetOrdersByCustomer",
          data: filterBodyParameter.filterToJson(), queryParameters: {'customerId': customerId}, cancelToken: cancelToken);

      if (response.statusCode == 200) {
        final CustomerOrdersResponse res = CustomerOrdersResponse.fromJson(response.data);

        return res;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      if (error.message == Defaults.canceledRequest) {
        throw const RequestException("Force canceled");
      }
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<bool> createCustomerPayment(CreateCustomerPaymentParameter parameter) async {
    try {
      final Response response = await _dioClient.post("CustomerPayment/Add", data: parameter.toJson());

      if (response.statusCode == 200) {
        return true;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      if (error.message == Defaults.canceledRequest) {
        throw const RequestException("Force canceled");
      }
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<CreditHistoriesResponse> getCustomerCreditHistories(CustomerCreditHistoriesParameter parameter) async {
    try {
      final Response response = await _dioClient.get("CustomerPayment/GetCustomerBalance", queryParameters: parameter.toJson());

      if (response.statusCode == 200) {
        return CreditHistoriesResponse.fromJson(response.data);
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<bool> deleteCustomer(String customerId) async {
    try {
      final Response response = await _dioClient.delete("Customer/Delete", queryParameters: {'customerId': customerId});

      if (response.statusCode == 200) {
        return true;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }
}
