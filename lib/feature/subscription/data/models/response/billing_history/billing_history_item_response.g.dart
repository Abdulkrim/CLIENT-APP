// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'billing_history_item_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BillingHistoryItemResponse _$BillingHistoryItemResponseFromJson(
        Map<String, dynamic> json) =>
    BillingHistoryItemResponse(
      id: json['id'] as String?,
      currency: json['currency'] == null
          ? null
          : CurrencyInfoResponse.fromJson(
              json['currency'] as Map<String, dynamic>),
      amount: json['amount'] as num?,
      branch: json['branch'] == null
          ? null
          : BranchResponse.fromJson(json['branch'] as Map<String, dynamic>),
      paidOn: json['paidOn'] as String?,
      paymentModeId: (json['paymentModeId'] as num?)?.toInt(),
      paymentMode: json['paymentMode'] == null
          ? null
          : PaymentModeResponse.fromJson(
              json['paymentMode'] as Map<String, dynamic>),
      referenceNumber: json['referenceNumber'] as String?,
      paymentStatus: json['paymentStatus'] == null
          ? null
          : PaymentStatusResponse.fromJson(
              json['paymentStatus'] as Map<String, dynamic>),
      downloadUrl: json['downloadUrl'] as String?,
      invoiceId: json['invoiceId'] as String?,
    );

Map<String, dynamic> _$BillingHistoryItemResponseToJson(
        BillingHistoryItemResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'currency': instance.currency,
      'amount': instance.amount,
      'branch': instance.branch,
      'paidOn': instance.paidOn,
      'paymentModeId': instance.paymentModeId,
      'paymentMode': instance.paymentMode,
      'referenceNumber': instance.referenceNumber,
      'paymentStatus': instance.paymentStatus,
      'invoiceId': instance.invoiceId,
      'downloadUrl': instance.downloadUrl,
    };
