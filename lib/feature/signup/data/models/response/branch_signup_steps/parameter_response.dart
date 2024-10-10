import 'package:json_annotation/json_annotation.dart';

import '../../../../../settings/data/models/response/payment/payment_types_response.dart';

part 'parameter_response.g.dart';

@JsonSerializable()
class ParameterResponse {
  String? branchParamID;
  bool? customerAllowed;
  int? queueAllowed;
  int? discountAllowed;
  int? businessDayAllowed;
  bool? businessShiftAllowed;
  PaymentTypesResponse? branchPaymentModes;
  int? claimAllowed;

  bool? taxAllowed;
  bool? smsAllowed;
  int? trn;
  int? decimalPoint;
  bool? nfcProductSearch;
  int? taxID;
  String? branchID;
  int? taxTypeId;

  ParameterResponse(
      {this.branchParamID,
      this.customerAllowed,
      this.queueAllowed,
      this.discountAllowed,
      this.claimAllowed,
      this.businessDayAllowed,
      this.businessShiftAllowed,
      this.branchPaymentModes,
      this.taxAllowed,
      this.smsAllowed,
      this.trn,
      this.decimalPoint,
      this.nfcProductSearch,
      this.taxID,
      this.branchID,
      this.taxTypeId});

  factory ParameterResponse.fromJson(Map<String, dynamic> json) => _$ParameterResponseFromJson(json);
}
