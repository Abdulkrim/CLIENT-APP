part of 'cashier_bloc.dart';

abstract class CashierEvent extends Equatable {
  const CashierEvent();
}

class CashierTopTabBarSelectedEvent extends CashierEvent {
  final int selectedPosition;

  const CashierTopTabBarSelectedEvent(this.selectedPosition);

  @override
  List<Object> get props => [selectedPosition];
}

class GetAllCashiersEvent extends CashierEvent {
  final bool getMore;

  const GetAllCashiersEvent.refresh() : getMore = false;

  const GetAllCashiersEvent({required this.getMore});

  @override
  List<Object?> get props => [];
}

class GetAllCashiersSalesEvent extends CashierEvent {
  final String? fromDate;
  final String? toDate;
  final CashierSortTypes? selectedCashierSortType;

  final bool getMore;

  const GetAllCashiersSalesEvent(
      {this.fromDate, this.toDate, this.selectedCashierSortType, this.getMore = false});

  @override
  List<Object?> get props => [fromDate, toDate, selectedCashierSortType];
}

class GetCashierRolesRequestEvent extends CashierEvent {
  const GetCashierRolesRequestEvent();

  @override
  List<Object> get props => [];
}

class AddCashierRequestEvent extends CashierEvent {
  final String cashierName;
  final String cashierPassword;
  final int cashierRoleId;

  const AddCashierRequestEvent(
      {required this.cashierName, required this.cashierPassword, required this.cashierRoleId});

  @override
  List<Object> get props => [
        cashierName,
        cashierPassword,
        cashierRoleId,
      ];
}

class EditCashierRequestEvent extends CashierEvent {
  final String cashierId;
  final String cashierName;

  final int cashierRoleId;
  final String cashierRoleName;
  final bool isActive;

  const EditCashierRequestEvent(
      {required this.cashierId,
      required this.cashierRoleName,
      required this.cashierName,
      required this.isActive,
      required this.cashierRoleId});

  @override
  List<Object> get props => [
        cashierId,
        cashierName,
        isActive,
    cashierRoleName,
        cashierRoleId,
      ];
}

class ChangeSalesCashierOrder extends CashierEvent {
  final CashierSortTypes salesSortType;

  const ChangeSalesCashierOrder(this.salesSortType);

  @override
  List<Object> get props => [salesSortType];
}
