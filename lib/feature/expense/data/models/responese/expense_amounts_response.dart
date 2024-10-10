import 'package:merchant_dashboard/feature/expense/data/models/entity/expense_amount.dart';

class ExpenseAmountsResponse {
  List<Value>? value;
  int? currentPageNumber;
  int? totalPageCount;

  ExpenseAmountsResponse({this.value, this.currentPageNumber, this.totalPageCount});

  ExpenseAmountsResponse.fromJson(Map<String, dynamic> json)
      : value = (json['value'] as List<dynamic>?)?.map((e) => Value.fromJson(e)).toList() ?? [],
        currentPageNumber = json['currentPageNumber'],
        totalPageCount = json['totalPageCount'];

  List<ExpenseAmount> toEntity() => value?.map((e) => ExpenseAmount(e.amount ?? '')).toList() ?? [];
}

class Value {
  String? amount;

  Value({this.amount});

  Value.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
  }
}
