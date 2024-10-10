import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/core/constants/defaults.dart';
import 'package:merchant_dashboard/feature/customers/data/data_source/customer_remote_datasource.dart';
import 'package:merchant_dashboard/feature/customers/data/models/entity/customer_credit_history.dart';
import 'package:merchant_dashboard/feature/customers/data/models/entity/customer_list_info.dart';
import 'package:merchant_dashboard/feature/customers/data/models/params/create_customer_payment_parameter.dart';
import 'package:merchant_dashboard/feature/customers/data/models/params/customer_credit_histories_parameter.dart';
import 'package:merchant_dashboard/feature/customers/data/models/params/customer_parameter.dart';
import 'package:merchant_dashboard/feature/customers/data/models/response/info/customers_response.dart';
import 'package:merchant_dashboard/feature/customers/data/models/response/orders/customer_orders_response.dart';
import '../../../../core/utils/exceptions.dart';
import '../../../../core/utils/failure.dart';
import '../../../../core/client/parameter/base_filter_parameter.dart';
import '../models/entity/customer_orders.dart';

abstract class ICustomerRepository {
  Future<Either<Failure, Customer>> getSpecificCustomer(String phoneNumber);

  Future<Either<Failure, bool>> addCustomer(CustomerParameter customerParameter);

  Future<Either<Failure, bool>> deleteCustomer(String customerId);

  Future<Either<Failure, CustomerListInfo>> getAllCustomers(int currentPage, String? searchText);

  Future<Either<Failure, CustomerOrders>> getCustomerOrders(String customerId, int currentPage);


  Future<Either<Failure, bool>> editCustomer(CustomerParameter customerParameter);

  Future<Either<Failure, bool>> createCustomerPayment(
      {required String customerId,
      required List<({int paymentModeId, num amount, String? refrenceNumber})> selectedPaymentModes});

  Future<Either<Failure, List<CustomerCreditHistory>>> getCustomerCreditHistories(
      {required String customerId, required String fromDate, required String toDate});


  Future<Either<Failure, Customer>> getCustomerDetails(String customerId);
}

@LazySingleton(as: ICustomerRepository)
class CustomerRepository extends ICustomerRepository {
  final ICustomerRemoteDataSource _customerRemoteDataSource;

  CustomerRepository(this._customerRemoteDataSource);

  @override
  Future<Either<Failure, bool>> addCustomer(CustomerParameter customerParameter) async {
    try {
      final bool response = await _customerRemoteDataSource.addCustomer(customerParameter);

      return Right(response);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, bool>> editCustomer(CustomerParameter customerParameter) async {
    try {
      final bool response = await _customerRemoteDataSource.editCustomer(customerParameter);

      return Right(response);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, CustomerListInfo>> getAllCustomers(int currentPage, String? searchText) async {
    try {
      final parameter = BaseFilterListParameter(page: currentPage, filterInfo: [
        if (searchText != null) ...[
          BaseFilterInfoParameter(
            logical: LogicalOperator.or.value,
            operator: QueryOperator.contains.value,
            propertyName: 'fullname',
            value: searchText.trim(),
          ),
          BaseFilterInfoParameter(
            logical: LogicalOperator.or.value,
            operator: QueryOperator.contains.value,
            propertyName: 'phoneNumber',
            value: searchText.trim(),
          ),
        ]
      ]);

      final CustomersResponse response = await _customerRemoteDataSource.getAllCustomers(parameter);

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }


  @override
  Future<Either<Failure, Customer>> getSpecificCustomer(String phoneNumber) async {
    try {
      final response = await _customerRemoteDataSource.getSpecificCustomer(phoneNumber);

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, CustomerOrders>> getCustomerOrders(String customerId, int currentPage) async {
    try {
      final BaseFilterListParameter parameter = BaseFilterListParameter(
          page: currentPage, orderInfo: [BaseSortInfoParameter(orderType: OrderOperator.desc.value, property: 'CreatedAt')]);
      final CustomerOrdersResponse response = await _customerRemoteDataSource.getCustomerOrders(parameter, customerId);

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, bool>> createCustomerPayment(
      {required String customerId,
      required List<({num amount, int paymentModeId, String? refrenceNumber})> selectedPaymentModes}) async {
    try {
      final response = await _customerRemoteDataSource.createCustomerPayment(
          CreateCustomerPaymentParameter(customerId: customerId, selectedPaymentTypes: selectedPaymentModes));

      return Right(response);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, List<CustomerCreditHistory>>> getCustomerCreditHistories(
      {required String customerId, required String fromDate, required String toDate}) async {
    try {
      final response = await _customerRemoteDataSource.getCustomerCreditHistories(
          CustomerCreditHistoriesParameter(customerId: customerId, fromDate: fromDate, toDate: toDate));

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, Customer>> getCustomerDetails(String customerId) async {
    try {
      final response = await _customerRemoteDataSource.getCustomerDetails(customerId);

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteCustomer(String customerId) async {
    try {
      final response = await _customerRemoteDataSource.deleteCustomer(customerId);

      return Right(response );
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }
}
