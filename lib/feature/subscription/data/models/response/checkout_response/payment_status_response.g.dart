// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_status_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentStatusInfoResponse _$PaymentStatusInfoResponseFromJson(
        Map<String, dynamic> json) =>
    PaymentStatusInfoResponse(
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
      invoiceId: json['invoiceId'] as String?,
      paymentModeId: (json['paymentModeId'] as num?)?.toInt(),
      paymentMode: json['paymentMode'] == null
          ? null
          : PaymentMode.fromJson(json['paymentMode'] as Map<String, dynamic>),
      referenceNumber: json['referenceNumber'] as String?,
      paymentStatus: json['paymentStatus'] == null
          ? null
          : PaymentStatusResponse.fromJson(
              json['paymentStatus'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PaymentStatusInfoResponseToJson(
        PaymentStatusInfoResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'currency': instance.currency,
      'amount': instance.amount,
      'branch': instance.branch,
      'paidOn': instance.paidOn,
      'paymentModeId': instance.paymentModeId,
      'paymentMode': instance.paymentMode,
      'referenceNumber': instance.referenceNumber,
      'invoiceId': instance.invoiceId,
      'paymentStatus': instance.paymentStatus,
    };
