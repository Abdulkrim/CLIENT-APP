import '../entity/cashier_role.dart';

class CashierRolesResponse {
  List<PosRoles>? posRoles;
  String? message;
  int? statusCode;
  bool? isSucceeded;

  CashierRolesResponse({this.posRoles, this.message, this.statusCode, this.isSucceeded});

  CashierRolesResponse.fromJson(Map<String, dynamic> json) {
    if (json['posRoles'] != null) {
      posRoles = <PosRoles>[];
      json['posRoles'].forEach((v) {
        posRoles!.add(PosRoles.fromJson(v));
      });
    }
    message = json['message'];
    statusCode = json['statusCode'];
    isSucceeded = json['isSucceeded'];
  }

  List<CashierRole> toEntity() =>
      posRoles?.map((e) => CashierRole(roleName: e.posRoleName ?? '', roleCode: e.posRoleId ?? 0)).toList() ??
      [];
}

class PosRoles {
  int? posRoleId;
  String? posRoleName;

  PosRoles({this.posRoleId, this.posRoleName});

  PosRoles.fromJson(Map<String, dynamic> json) {
    posRoleId = json['posRoleId'];
    posRoleName = json['posRoleName'];
  }
}
