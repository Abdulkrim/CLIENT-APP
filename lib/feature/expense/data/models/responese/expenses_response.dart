import 'package:merchant_dashboard/feature/expense/data/models/entity/expenses_info.dart';

import 'expense_item_response.dart';

class ExpensesResponse {
  List<ExpenseItemResponse>? value;
  int? currentPageNumber;
  int? totalPageCount;
  num? totalAmount;

  ExpensesResponse({this.value, this.currentPageNumber, this.totalPageCount, this.totalAmount});

  ExpensesResponse.fromJson(Map<String, dynamic> json) {
    if (json['value'] != null) {
      value = <ExpenseItemResponse>[];
      json['value'].forEach((v) {
        value!.add(ExpenseItemResponse.fromJson(v));
      });
    }
    currentPageNumber = json['currentPageNumber'];
    totalPageCount = json['totalPageCount'];
    totalAmount = json['totalAmount'];
  }

  ExpensesInfo toEntity() => ExpensesInfo(
      items: value
              ?.map((e) => ExpenseItem(
                  id: e.id ?? 0,
                  expenseTypeId: e.expenseTypeId ?? 0,
                  expenseTypeName: e.expenseTypeName ?? '',
                  paymentModeId: e.paymentModeId ?? 0,
                  paymentModeName: e.paymentModeName ?? '',
                  amount: e.amount ?? 0,
                  note: e.note ?? '',
                  fileUrl: e.fileUrl ?? '',
                  date: e.date ?? ''))
              .toList() ??
          [],
      totalAmount: totalAmount ?? 0,
      currentPageNumber: currentPageNumber ?? 1,
      totalPageCount: totalPageCount ?? 1);
}
