import 'package:json_annotation/json_annotation.dart';

part 'expense_item_response.g.dart';

@JsonSerializable()
class ExpenseItemResponse {
  int? id;
  String? branchId;
  int? expenseTypeId;
  String? expenseTypeName;
  int? paymentModeId;
  String? paymentModeName;
  String? createAt;
  num? amount;
  String? note;
  String? fileUrl;
  num? totalAmount;
  String? date;

  ExpenseItemResponse(
      {this.id,
      this.branchId,
      this.expenseTypeId,
      this.totalAmount,
      this.expenseTypeName,
      this.paymentModeId,
      this.paymentModeName,
      this.createAt,
      this.amount,
      this.note,
      this.fileUrl,
      this.date});

  factory ExpenseItemResponse.fromJson(Map<String, dynamic> json) => _$ExpenseItemResponseFromJson(json);
}
