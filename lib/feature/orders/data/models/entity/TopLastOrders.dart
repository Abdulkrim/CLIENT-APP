import '../../../../../utils/mixins/date_time_utilities.dart';

/// id : "c7cb36a6-e69b-4fc5-b271-0aa6e3e00b82"
/// branchId : "30f03d2e-59b2-44c7-ad2d-45d018fbcc1d"
/// orderDate : "2023-08-31T16:50:36.555+04:00"
/// totalFinalPrice : 20.000

class TopLastOrdersModel with DateTimeUtilities {
  TopLastOrdersModel({
    String? id,
    String? branchId,
    String? orderDate,
    num? totalFinalPrice,
  }) {
    _id = id;
    _branchId = branchId;
    _orderDate = orderDate;
    _totalFinalPrice = totalFinalPrice;
  }

  TopLastOrdersModel.fromJson(dynamic json) {
    _id = json['id'];
    _branchId = json['branchId'];
    _orderDate = json['orderDate'];
    _totalFinalPrice = json['totalFinalPrice'];
  }

  String? _id;
  String? _branchId;
  String? _orderDate;
  num? _totalFinalPrice;

  TopLastOrdersModel copyWith({
    String? id,
    String? branchId,
    String? orderDate,
    num? totalFinalPrice,
  }) =>
      TopLastOrdersModel(
        id: id ?? _id,
        branchId: branchId ?? _branchId,
        orderDate: orderDate ?? _orderDate,
        totalFinalPrice: totalFinalPrice ?? _totalFinalPrice,
      );

  String? get id => _id;

  String? get branchId => _branchId;

  String? get orderDate => convertDateFormat(_orderDate ?? '');

  num? get totalFinalPrice => _totalFinalPrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['branchId'] = _branchId;
    map['orderDate'] = _orderDate;
    map['totalFinalPrice'] = _totalFinalPrice;
    return map;
  }
}
