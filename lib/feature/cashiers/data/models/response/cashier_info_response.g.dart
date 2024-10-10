// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cashier_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CashierInfoResponse _$CashierInfoResponseFromJson(Map<String, dynamic> json) =>
    CashierInfoResponse(
      cashierName: json['cashierName'] as String?,
      branchId: json['branchId'] as String?,
      cashierPassword: json['cashierPassword'] as String?,
      cashierId: json['cashierId'] as String?,
      posRoleId: (json['posRoleId'] as num?)?.toInt(),
      roleName: json['roleName'] as String?,
      isActive: json['isActive'] as bool?,
      total: json['total'] as num?,
    );

Map<String, dynamic> _$CashierInfoResponseToJson(
        CashierInfoResponse instance) =>
    <String, dynamic>{
      'cashierName': instance.cashierName,
      'branchId': instance.branchId,
      'cashierId': instance.cashierId,
      'cashierPassword': instance.cashierPassword,
      'posRoleId': instance.posRoleId,
      'roleName': instance.roleName,
      'isActive': instance.isActive,
      'total': instance.total,
    };
