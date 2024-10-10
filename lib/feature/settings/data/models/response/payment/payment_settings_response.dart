import 'package:json_annotation/json_annotation.dart';
import 'package:merchant_dashboard/feature/settings/data/models/entity/payment_settings.dart';
import 'package:merchant_dashboard/feature/settings/data/models/entity/payment_type.dart';

import 'payment_types_response.dart';

part 'payment_settings_response.g.dart';

@JsonSerializable()
class PaymentSettingsResponse {
  int? claimAllowed;
  List<PaymentTypeItemResponse>? branchPaymentModes;
  String? claimAllowedString;
  bool? customerAllowed;
  bool? taxAllowed;
  String? trn;
  int? taxID;
  int? taxTypeId;

  PaymentSettingsResponse(
      {this.claimAllowed,
      this.branchPaymentModes,
      this.claimAllowedString,
      this.taxID,
      this.taxAllowed,
      this.customerAllowed,
      this.taxTypeId,
      this.trn});

  factory PaymentSettingsResponse.fromJson(Map<String, dynamic> json) => _$PaymentSettingsResponseFromJson(json);

  PaymentSettings toEntity() => PaymentSettings(
      claimAllowed: claimAllowed ?? 0,
      payment: branchPaymentModes
              ?.map(
                (e) => PaymentType(id: e.id ?? 0, name: e.name ?? '', isDefault: e.isDefault ?? false),
              )
              .toList() ??
          [],
      customerAllowed: customerAllowed ?? false,
      taxAllowed: taxAllowed ?? false,
      taxTypeId: taxTypeId ?? 0,
      trn: int.tryParse(trn ?? '0') ?? 0);
}
