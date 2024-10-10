import 'package:json_annotation/json_annotation.dart';
import 'package:merchant_dashboard/feature/signup/data/models/response/branch_signup_steps/branch_response.dart';
import '../../../../../orders/data/models/response/all_orders/order_item_response.dart';
import '../checkout_response/payment_status_response.dart';
import '../plans/currency_info_response.dart';

part 'billing_history_item_response.g.dart';

@JsonSerializable()
class BillingHistoryItemResponse {
  String? id;
  CurrencyInfoResponse? currency;
  num? amount;
  BranchResponse? branch;
  String? paidOn;
  int? paymentModeId;
  PaymentModeResponse? paymentMode;
  String? referenceNumber;
  PaymentStatusResponse? paymentStatus;
  String? invoiceId;
  String? downloadUrl;

  BillingHistoryItemResponse(
      {this.id,
      this.currency,
      this.amount,
      this.branch,
      this.paidOn,
      this.paymentModeId,
      this.paymentMode,
      this.referenceNumber,
      this.paymentStatus,
      this.downloadUrl,
      this.invoiceId});

  factory BillingHistoryItemResponse.fromJson(Map<String, dynamic> json) =>
      _$BillingHistoryItemResponseFromJson(json);
}
