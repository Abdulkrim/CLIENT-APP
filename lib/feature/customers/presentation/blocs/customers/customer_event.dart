part of 'customer_bloc.dart';

abstract class CustomerEvent extends Equatable {
  const CustomerEvent();

  @override
  List<Object?> get props => [];
}

class GetAllCustomersEvent extends CustomerEvent {
  final bool getMore;
  final String? searchText;

  const GetAllCustomersEvent.refresh({this.searchText}) : getMore = false;

  const GetAllCustomersEvent({required this.getMore, this.searchText});
}


class GetCustomerTransactions extends CustomerEvent {
  final bool getMore;

  const GetCustomerTransactions({this.getMore = false});
}

class GetCustomerOrders extends CustomerEvent {
  final bool getMore;

  const GetCustomerOrders({this.getMore = false});
}

class SearchForCustomer extends CustomerEvent {
  final String phoneNumber;

  const SearchForCustomer(this.phoneNumber);

  @override
  List<Object> get props => [phoneNumber];
}
class GetCustomerDetails extends CustomerEvent {
  final String customerId;

  const GetCustomerDetails(this.customerId);

  @override
  List<Object> get props => [customerId];
}
class DeleteCustomerEvent extends CustomerEvent {
  final String customerId;

  const DeleteCustomerEvent(this.customerId);

  @override
  List<Object> get props => [customerId];
}

class AddCustomerEvent extends CustomerEvent {
  final CustomerParameter customerParameter;

  const AddCustomerEvent({required this.customerParameter});

  @override
  List<Object> get props => [customerParameter];
}

class EditCustomerEvent extends CustomerEvent {
  final CustomerParameter customerParameter;

  const EditCustomerEvent({required this.customerParameter});

  @override
  List<Object> get props => [customerParameter];
}
