import '../../../../../utils/mixins/mixins.dart';

class CashierListInfo {
  final int currentPageNumber;
  final int totalPageCount;

  final List<Cashier> cashiers;

  CashierListInfo({required this.currentPageNumber, required this.totalPageCount, required this.cashiers});
}

class Cashier with ProfileBGColorGenerator {
  final String id;
  final num totalSales;
  String name;
  int cashierRoleId;
  String cashierRole;

  bool status;

  String get statusLabel => (status) ? 'Active' : 'InActive';

  Cashier({
    required this.id,
    required this.name,
    required this.status,
    required this.totalSales,
    required this.cashierRoleId,
    required this.cashierRole,
  });

  void update(
      {required String cashierName, required int cashierRoleId, required String cashierRoleName, required bool isActive}) {
    name = cashierName;
    this.cashierRoleId = cashierRoleId;
    cashierRole = cashierRoleName;
    status = isActive;
  }
}
