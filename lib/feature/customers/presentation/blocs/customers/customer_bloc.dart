import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/feature/main_screen/presentation/blocs/main_screen_bloc.dart';
import 'package:merchant_dashboard/feature/transaction/data/repository/transaction_repository.dart';
import 'package:merchant_dashboard/injection.dart';

import '../../../../../core/bloc_base_state/pagination_state.dart';
import '../../../../../core/constants/defaults.dart';
import '../../../../../core/utils/failure.dart';
import '../../../../transaction/data/models/entity/transaction.dart';
import '../../../data/models/entity/customer_list_info.dart';
import '../../../data/models/entity/customer_orders.dart';
import '../../../data/models/params/customer_parameter.dart';
import '../../../data/repository/customer_repository.dart';

part 'customer_event.dart';

part 'customer_state.dart';

@injectable
class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  final ITransactionRepository _transactionRepository;
  final ICustomerRepository _customerRepository;

  final PaginationState<Transaction> transactionsPagination = PaginationState<Transaction>();
  final PaginationState<CustomerOrder> ordersPagination = PaginationState<CustomerOrder>();
  final PaginationState<Customer> customerPagination = PaginationState<Customer>();

  Customer? foundCustomer;

  CustomerBloc(this._customerRepository, this._transactionRepository) : super(CustomerInitial()) {
    getIt<MainScreenBloc>().stream.listen((event) {
      if (event is MerchantInfoSelectionChangedState && event.merchantInfo.hasData) {
        add(const GetAllCustomersEvent.refresh());
      }
    });

    on<AddCustomerEvent>((event, emit) async {
      emit(const UpdateCustomerState(isLoading: true));

      final Either<Failure, bool> result = await _customerRepository.addCustomer(event.customerParameter);

      result.fold((left) => emit(UpdateCustomerState(errorMessage: left.errorMessage)), (right) {
        emit(const UpdateCustomerState(message: 'Customer added successfully.'));
      });
    });


    on<DeleteCustomerEvent>((event, emit) async {
      emit(const UpdateCustomerState(isLoading: true));

      final Either<Failure, bool> result = await _customerRepository.deleteCustomer(event.customerId);

      result.fold((left) => emit(UpdateCustomerState(errorMessage: left.errorMessage)), (right) {
        add(const GetAllCustomersEvent(getMore: false));
        emit(const UpdateCustomerState(message: 'Customer deleted successfully.'));
      });
    });

    on<GetCustomerDetails>((event, emit) async {
      _resetAllData();

      emit(const GetCustomerDetailsState(isLoading: true));
      final Either<Failure, Customer> result = await _customerRepository.getCustomerDetails(event.customerId);

      result.fold((left) => emit(GetCustomerDetailsState(errorMessage: left.errorMessage)), (right) {
        foundCustomer = right;
        emit(const GetCustomerDetailsState(isSuccess: true));
      });
    });

    on<EditCustomerEvent>((event, emit) async {
      emit(const UpdateCustomerState(isLoading: true));

      final Either<Failure, bool> result = await _customerRepository.editCustomer(event.customerParameter);

      result.fold((left) => emit(UpdateCustomerState(errorMessage: left.errorMessage)), (right) {
        emit(const UpdateCustomerState(message: 'Customer added successfully.'));
      });
    });

    on<GetAllCustomersEvent>((event, emit) async {
      if (!event.getMore) {
        await customerPagination.dispose();
      } else if (customerPagination.onFetching) {
        return;
      }

      if (customerPagination.hasMore) {
        if (customerPagination.currentPage == 1) emit(const GetCustomerLoadingState());

        customerPagination.sendRequestForNextPage();

        Either<Failure, CustomerListInfo> customerRes =
            await _customerRepository.getAllCustomers(customerPagination.currentPage, event.searchText);

        customerRes.fold((left) {
          customerPagination.dispose();
          emit(const GetCustomerFailedSate());
        }, (right) {
          customerPagination.gotNextPageData(right.customers, right.totalPageCount);
          emit(GetAllCustomersSuccessState(right.currentPageNumber, customerPagination.hasMore));
        });
      }
    });

    on<SearchForCustomer>((event, emit) async {
      if (event.phoneNumber.isNotEmpty) {
        _resetAllData();

        emit(const GetCustomerLoadingState());
        final searchResponse = await _customerRepository.getSpecificCustomer(event.phoneNumber.trim());

        searchResponse.fold((left) {
          if (left.errorMessage != Defaults.canceledRequest) {
            emit(const SearchCustomerFailedState());
          }
        }, (right) {
          foundCustomer = right;
          emit(SearchCustomerSuccessState(right));
          add(const GetCustomerTransactions());
          add(const GetCustomerOrders());
        });
      }
    });

    on<GetCustomerTransactions>((event, emit) async {
      if (!event.getMore) {
        await transactionsPagination.dispose();
      } else if (transactionsPagination.onFetching) {
        return;
      }

      if (transactionsPagination.hasMore) {
        if (transactionsPagination.currentPage == 1) emit(const GetCustomerTransactionsLoadingState());

        transactionsPagination.sendRequestForNextPage();

        Either<Failure, TransactionListInfo> transResult = await _transactionRepository.getAllCustomerTransaction(
          foundCustomer?.id ?? '',
          transactionsPagination.currentPage,
        );

        transResult.fold((left) {
          transactionsPagination.dispose();
          emit(const GetCustomerTransactionsFailedState());
        }, (right) {
          transactionsPagination.gotNextPageData(right.transactions, right.totalPageCount);
          emit(GetCustomerTransactionsSuccessState(right.currentPageNumber, transactionsPagination.hasMore));
        });
      }
    });

    on<GetCustomerOrders>((event, emit) async {
      if (!event.getMore) {
        await ordersPagination.dispose();
      } else if (ordersPagination.onFetching) {
        return;
      }

      if (ordersPagination.hasMore) {
        if (ordersPagination.currentPage == 1) emit(const GetCustomerOrdersLoadingState());

        ordersPagination.sendRequestForNextPage();

        Either<Failure, CustomerOrders> transResult = await _customerRepository.getCustomerOrders(
          foundCustomer?.id ?? '',
          ordersPagination.currentPage,
        );

        transResult.fold((left) {
          ordersPagination.dispose();
          emit(const GetCustomerOrdersFailedState());
        }, (right) {
          ordersPagination.gotNextPageData(right.orders, right.totalPageCount);
          emit(GetCustomerOrdersSuccessState(right.currentPageNumber, ordersPagination.hasMore));
        });
      }
    });
  }

  _resetAllData() {
    foundCustomer = null;
    ordersPagination.dispose();
    transactionsPagination.dispose();
  }
}
