part of 'customer_bloc.dart';

abstract class CustomerState extends Equatable {
  const CustomerState();

  @override
  List<Object?> get props => [];
}

class CustomerInitial extends CustomerState {}

class CustomerListLoadingState extends CustomerState {
  const CustomerListLoadingState();
}

class EditCustomerLoadingState extends CustomerState {
  const EditCustomerLoadingState();
}

class CustomerListSuccessState extends CustomerState {
  final int currentPageNumber;
  final bool hasMore;

  const CustomerListSuccessState(this.currentPageNumber, this.hasMore);

  @override
  List<Object> get props => [currentPageNumber, hasMore];
}

class GetCustomerTransactionsLoadingState extends CustomerState {
  const GetCustomerTransactionsLoadingState();
}

class GetAllCustomersSuccessState extends CustomerState {
  final int currentPage;
  final bool hasMore;

  const GetAllCustomersSuccessState(this.currentPage, this.hasMore);

  @override
  List<Object> get props => [currentPage, hasMore];
}

class GetCustomerTransactionsSuccessState extends CustomerState {
  final int currentPage;
  final bool hasMore;

  const GetCustomerTransactionsSuccessState(this.currentPage, this.hasMore);

  @override
  List<Object> get props => [currentPage, hasMore];
}

class GetCustomerTransactionsFailedState extends CustomerState {
  const GetCustomerTransactionsFailedState();
}

class GetCustomerLoadingState extends CustomerState {
  const GetCustomerLoadingState();
}

class GetCustomerFailedSate extends CustomerState {
  const GetCustomerFailedSate();
}

class SearchCustomerFailedState extends CustomerState {
  const SearchCustomerFailedState();
}

class SearchCustomerSuccessState extends CustomerState {
  final Customer foundCustomer;

  const SearchCustomerSuccessState(this.foundCustomer);

  @override
  List<Object> get props => [foundCustomer];
}

class GetCustomerOrdersLoadingState extends CustomerState {
  const GetCustomerOrdersLoadingState();
}

class GetCustomerOrdersFailedState extends CustomerState {
  const GetCustomerOrdersFailedState();
}

class GetCustomerOrdersSuccessState extends CustomerState {
  final int currentPage;
  final bool hasMore;

  const GetCustomerOrdersSuccessState(this.currentPage, this.hasMore);

  @override
  List<Object> get props => [currentPage, hasMore];
}

class GetCustomerDetailsState extends CustomerState {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;

  const GetCustomerDetailsState({this.isLoading = false, this.isSuccess = false, this.errorMessage});

  @override
  List<Object?> get props => [isLoading, isSuccess, errorMessage];
}

class UpdateCustomerState extends CustomerState {
  final bool isLoading;
  final String message;
  final String? errorMessage;

  const UpdateCustomerState({this.isLoading = false, this.message = '', this.errorMessage});

  @override
  List<Object?> get props => [isLoading, message, errorMessage];
}
