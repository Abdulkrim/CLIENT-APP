import '../entity/cashier.dart';

class CashierSummerizedResponse {
  List<CashierSummerizedItemResponse>? cashiers;
  String? message;
  int? statusCode;
  bool? isSucceeded;

  CashierSummerizedResponse({this.cashiers, this.message, this.statusCode, this.isSucceeded});

  CashierSummerizedResponse.fromJson(Map<String, dynamic> json) {
    if (json['cashiers'] != null) {
      cashiers = <CashierSummerizedItemResponse>[];
      json['cashiers'].forEach((v) {
        cashiers!.add(CashierSummerizedItemResponse.fromJson(v));
      });
    }
    message = json['message'];
    statusCode = json['statusCode'];
    isSucceeded = json['isSucceeded'];
  }

  CashierListInfo toEntity() => CashierListInfo(
      currentPageNumber: 1,
      totalPageCount: 1,
      cashiers: cashiers
              ?.map((e) => Cashier(
                  id: e.userId ?? '',
                  name: e.userName ?? '',
                  status: true,
                  totalSales: 0,
                  cashierRoleId: 0,
                  cashierRole: ''))
              .toList() ??
          []);
}

class CashierSummerizedItemResponse {
  String? userId;
  String? userName;

  CashierSummerizedItemResponse({this.userId, this.userName});

  CashierSummerizedItemResponse.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
  }
}
