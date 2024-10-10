import 'package:merchant_dashboard/feature/settings/data/models/entity/payment_type.dart';

class PaymentTypesResponse {
  List<PaymentTypeItemResponse> items;

  PaymentTypesResponse(this.items);

  PaymentTypesResponse.fromJson(List<dynamic>? json)
      : items = json?.map((e) => PaymentTypeItemResponse.fromJson(e)).toList() ?? [];

  List<PaymentType> toEntity() =>
      items.map((e) => PaymentType(id: e.id ?? 0, name: e.name ?? '', canHaveReference: e.canHaveReference ?? false , isDefault: e.isDefault ?? false)).toList();

  Map<String, dynamic> toJson() => {};
}

class PaymentTypeItemResponse {
  int? id;
  String? name;
  bool? isDefault;
  bool? canHaveReference;

  PaymentTypeItemResponse({this.id, this.name, this.isDefault, this.canHaveReference});

  PaymentTypeItemResponse.fromJson(Map<String, dynamic> json) {
    id = json['paymentModeId'] ?? json['id'];
    name = json['paymentModeName'] ?? json['name'];
    canHaveReference = json['canHaveReference'] ?? false;
    isDefault = json['isDefault'] ?? false;
  }

  Map<String, dynamic> toJson() => {};
}
