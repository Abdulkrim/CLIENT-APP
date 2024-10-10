import 'package:json_annotation/json_annotation.dart';
import 'package:merchant_dashboard/feature/signup/data/models/response/branch_signup_steps/branch_response.dart';
import 'package:merchant_dashboard/feature/subscription/data/models/entity/payment_status.dart';
import 'package:merchant_dashboard/feature/subscription/data/models/response/plans/currency_info_response.dart';

part 'payment_status_response.g.dart';

@JsonSerializable()
class PaymentStatusInfoResponse {
  String? id;
  CurrencyInfoResponse? currency;
  num? amount;
  BranchResponse? branch;
  String? paidOn;
  int? paymentModeId;
  PaymentMode? paymentMode;
  String? referenceNumber;
  String? invoiceId;
  PaymentStatusResponse? paymentStatus;

  PaymentStatusInfoResponse(
      {this.id,
      this.currency,
      this.amount,
      this.branch,
      this.paidOn,
      this.invoiceId,
      this.paymentModeId,
      this.paymentMode,
      this.referenceNumber,
      this.paymentStatus});

  PaymentStatus toEntity() => PaymentStatus(
      id: id ?? '',
      currency: currency?.name ?? '',
      branchName: branch?.name ?? '',
      amount: amount ?? 0,
      paidOn: paidOn ?? '',
      invoiceId: invoiceId ?? '',
      referenceNumber: referenceNumber ?? '',
      paymentStatus: paymentStatus?.name ?? '');

  factory PaymentStatusInfoResponse.fromJson(Map<String, dynamic> json) => _$PaymentStatusInfoResponseFromJson(json);
}

class PaymentMode {
  int? paymentModeId;
  String? paymentModeName;

  PaymentMode({this.paymentModeId, this.paymentModeName});

  PaymentMode.fromJson(Map<String, dynamic> json) {
    paymentModeId = json['paymentModeId'];
    paymentModeName = json['paymentModeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['paymentModeId'] = paymentModeId;
    data['paymentModeName'] = paymentModeName;
    return data;
  }
}

class PaymentStatusResponse {
  int? id;
  String? name;

  PaymentStatusResponse({this.id, this.name});

  PaymentStatusResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
