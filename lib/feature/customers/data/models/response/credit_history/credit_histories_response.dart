import '../../entity/customer_credit_history.dart';

class CreditHistoriesResponse {
  List<CreditHistoryItemResponse> data;

  CreditHistoriesResponse.fromJson(List<dynamic>? json)
      : data = json?.map((e) => CreditHistoryItemResponse.fromJson(e)).toList() ?? [];

  List<CustomerCreditHistory> toEntity() => data.map((e) => e.toEntity()).toList();
}

class CreditHistoryItemResponse {
  String? dateTime;
  String? type;
  num? amount;
  num? balance;
  int? id;

  CreditHistoryItemResponse({this.id, this.dateTime, this.type, this.amount, this.balance});

  CustomerCreditHistory toEntity() =>
      CustomerCreditHistory(id: id ?? 0, dateTime: dateTime ?? '', type: type ?? '', amount: amount ?? 0, balance: balance ?? 0);

  CreditHistoryItemResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateTime = json['dateTime'];
    type = json['type'];
    amount = json['amount'];
    balance = json['balance'];
  }
}
