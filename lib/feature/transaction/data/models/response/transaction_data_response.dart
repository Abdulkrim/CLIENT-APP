import 'package:json_annotation/json_annotation.dart';

import '../../../../orders/data/models/response/all_orders/order_item_response.dart';

part 'transaction_data_response.g.dart';

@JsonSerializable()
class TransactionDataResponse {
  int? transactionMasterId;
  String? offlineTransactionId;
  String? transactionDateTime;
  num? voucherNO;
  bool? isClaimed;
  String? couponCode;
  String? discountType;
  String? transactionUrl;
  num? discountValue;
  num? totalAmount;
  num? totalTaxAmount;
  num? totalDiscount;
  String? terminalId;
  num? paymentModeId;
  num? totalOriginalPrice;
  num? totalAfterDiscount;
  String? cashier;
  String? customer;
  String? customerId;
  String? customerPhoneNumber;
  String? paymentModeName;
  String? worker;
  num? deliveryDiscountPrice;
  num? deliveryFinalPrice;

  ParamObjectResponse? param1Object;
  ParamObjectResponse? param2Object;
  ParamObjectResponse? param3Object;

  TransactionDataResponse(
      {this.transactionMasterId,
      this.transactionDateTime,
      this.voucherNO,
      this.couponCode,
      this.offlineTransactionId,
      this.deliveryFinalPrice,
      this.deliveryDiscountPrice,
      this.discountType,
      this.discountValue,
      this.totalAmount,
      this.totalTaxAmount,
      this.totalDiscount,
      this.terminalId,
      this.paymentModeId,
      this.totalOriginalPrice,
      this.paymentModeName,
      this.totalAfterDiscount,
      this.worker,
      this.customer,
      this.customerId,
      this.customerPhoneNumber,
      this.transactionUrl,
      this.param1Object,
      this.param2Object,
      this.param3Object,
      this.isClaimed,
      this.cashier});

  factory TransactionDataResponse.fromJson(Map<String, dynamic> json) =>
      _$TransactionDataResponseFromJson(json);
}
