// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_item_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseItemResponse _$ExpenseItemResponseFromJson(Map<String, dynamic> json) =>
    ExpenseItemResponse(
      id: (json['id'] as num?)?.toInt(),
      branchId: json['branchId'] as String?,
      expenseTypeId: (json['expenseTypeId'] as num?)?.toInt(),
      totalAmount: json['totalAmount'] as num?,
      expenseTypeName: json['expenseTypeName'] as String?,
      paymentModeId: (json['paymentModeId'] as num?)?.toInt(),
      paymentModeName: json['paymentModeName'] as String?,
      createAt: json['createAt'] as String?,
      amount: json['amount'] as num?,
      note: json['note'] as String?,
      fileUrl: json['fileUrl'] as String?,
      date: json['date'] as String?,
    );

Map<String, dynamic> _$ExpenseItemResponseToJson(
        ExpenseItemResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'branchId': instance.branchId,
      'expenseTypeId': instance.expenseTypeId,
      'expenseTypeName': instance.expenseTypeName,
      'paymentModeId': instance.paymentModeId,
      'paymentModeName': instance.paymentModeName,
      'createAt': instance.createAt,
      'amount': instance.amount,
      'note': instance.note,
      'fileUrl': instance.fileUrl,
      'totalAmount': instance.totalAmount,
      'date': instance.date,
    };
