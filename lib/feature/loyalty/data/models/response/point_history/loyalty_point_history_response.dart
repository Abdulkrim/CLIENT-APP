import '../../entity/loyalty_point.dart';

class LoyaltyPointHistoryResponse {
  List<LoyaltyPointHistoryItemResponse>? value;
  int? currentPageNumber;
  int? totalPageCount;

  LoyaltyPointHistoryResponse({this.value, this.currentPageNumber, this.totalPageCount});

  LoyaltyPointHistoryResponse.fromJson(Map<String, dynamic> json) {
    if (json['value'] != null) {
      value = [];
      json['value'].forEach((v) {
        value!.add(LoyaltyPointHistoryItemResponse.fromJson(v));
      });
    }
    currentPageNumber = json['currentPageNumber'];
    totalPageCount = json['totalPageCount'];
  }

  LoyaltyPoint toEntity() => LoyaltyPoint(
      value
              ?.map((e) => LoyaltyPointItem(
                  reasonId: e.reasonId ?? 0,
                  reasonName: e.reasonName ?? '',
                  point: e.point ?? 0,
                  date: e.date ?? '',
                  balance: e.balance ?? 0))
              .toList() ??
          [],
      totalPageCount ?? 1);
}

class LoyaltyPointHistoryItemResponse {
  String? customerId;
  int? reasonId;
  String? reasonName;
  num? point;
  String? date;
  num? balance;

  LoyaltyPointHistoryItemResponse(
      {this.customerId, this.reasonId, this.reasonName, this.point, this.date, this.balance});

  LoyaltyPointHistoryItemResponse.fromJson(Map<String, dynamic> json) {
    customerId = json['customerId'];
    reasonId = json['reasonId'];
    reasonName = json['reasonName'];
    point = json['point'];
    date = json['date'];
    balance = json['balance'];
  }
}
