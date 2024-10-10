part of 'cashier_bloc.dart';

abstract class CashierState extends Equatable {
  const CashierState();

  @override
  List<Object> get props => [];
}

class CashierInitial extends CashierState {}

class CashierTopTabBarSelectedState extends CashierState {
  final int pos;

  const CashierTopTabBarSelectedState(this.pos);

  @override
  List<Object> get props => [pos];
}

class CashierListLoadingState extends CashierState {
  const CashierListLoadingState();
}

class CashierListSuccessState extends CashierState {
  final int currentPageNumber;
  final bool hasMore;
  const CashierListSuccessState(this.currentPageNumber, this.hasMore);

  @override
  List<Object> get props => [currentPageNumber, hasMore];
}

class SalesListSuccessState extends CashierState {
  const SalesListSuccessState();
}

class WrongDateFilterRangeEnteredState extends CashierState {
  final String fromDate;
  final String toDate;
  const WrongDateFilterRangeEnteredState(this.fromDate, this.toDate);

  @override
  List<Object> get props => [fromDate, toDate];
}

class EditCashierStates extends CashierState {
  final bool isLoading;
  final String successMsg;
  final String errorMessage;
  const EditCashierStates({this.isLoading = false, this.successMsg = '', this.errorMessage = ''});

  @override
  List<Object> get props => [isLoading, successMsg, errorMessage];
}

class CashierRolesFetchSuccessState extends CashierState {
  const CashierRolesFetchSuccessState();
}

class SalesCashiersListLoadingState extends CashierState {
  const SalesCashiersListLoadingState();
}

class SalesCashiersListSuccessState extends CashierState {
  final int currentPageNumber;
  final bool hasMore;
  const SalesCashiersListSuccessState(this.currentPageNumber, this.hasMore);

  @override
  List<Object> get props => [currentPageNumber, hasMore];
}
