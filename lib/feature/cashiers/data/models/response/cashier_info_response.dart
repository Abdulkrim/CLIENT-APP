import 'package:json_annotation/json_annotation.dart';

part 'cashier_info_response.g.dart';

@JsonSerializable()
class CashierInfoResponse {
  String? cashierName;
  String? branchId;
  String? cashierId;
  String? cashierPassword;
  int? posRoleId;
  String? roleName;
  bool? isActive;
  num? total;

  CashierInfoResponse({
    this.cashierName,
    this.branchId,
    this.cashierPassword,
    this.cashierId,
    this.posRoleId,
    this.roleName,
    this.isActive,
    this.total,
  });

  factory CashierInfoResponse.fromJson(Map<String, dynamic> json) => _$CashierInfoResponseFromJson(json);
}
