import 'package:merchant_dashboard/utils/mixins/date_time_utilities.dart';

class ExpensesInfo {
  final List<ExpenseItem> items;
  final int currentPageNumber;
  final int totalPageCount;
  final num totalAmount;

  ExpensesInfo({required this.items, required this.currentPageNumber, required this.totalPageCount, required this.totalAmount});
}

class ExpenseItem with DateTimeUtilities {
  final int id;
  final int expenseTypeId;
  final String expenseTypeName;
  final int paymentModeId;
  final String paymentModeName;
  final num amount;
  final String note;
  final String fileUrl;
  final String _date;

  String get formattedDate => convertDateFormat(_date, hasTime: false);

  ExpenseItem(
      {required this.id,
      required this.expenseTypeId,
      required this.expenseTypeName,
      required this.paymentModeId,
      required this.paymentModeName,
      required this.amount,
      required this.note,
      required this.fileUrl,
      required String date})
      : _date = date;
}
