import 'package:merchant_dashboard/feature/expense/data/models/entity/expense_type.dart';

class ExpenseTypesResponse {
  List<ExpenseTypeItemResponse>? items;

  ExpenseTypesResponse(this.items);

  ExpenseTypesResponse.fromJson(List<dynamic>? json)
      : items = json?.map((e) => ExpenseTypeItemResponse.fromJson(e)).toList() ?? [];

  List<ExpenseType> toEntity() => items?.map((e) => ExpenseType(e.id ?? 0, e.name ?? '')).toList() ?? [];
}

class ExpenseTypeItemResponse {
  int? id;
  String? businessId;
  String? name;

  ExpenseTypeItemResponse({this.id, this.businessId, this.name});

  ExpenseTypeItemResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    businessId = json['businessId'];
    name = json['name'];
  }
}
