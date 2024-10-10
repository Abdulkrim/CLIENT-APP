// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionDataResponse _$TransactionDataResponseFromJson(
        Map<String, dynamic> json) =>
    TransactionDataResponse(
      transactionMasterId: (json['transactionMasterId'] as num?)?.toInt(),
      transactionDateTime: json['transactionDateTime'] as String?,
      voucherNO: json['voucherNO'] as num?,
      couponCode: json['couponCode'] as String?,
      offlineTransactionId: json['offlineTransactionId'] as String?,
      deliveryFinalPrice: json['deliveryFinalPrice'] as num?,
      deliveryDiscountPrice: json['deliveryDiscountPrice'] as num?,
      discountType: json['discountType'] as String?,
      discountValue: json['discountValue'] as num?,
      totalAmount: json['totalAmount'] as num?,
      totalTaxAmount: json['totalTaxAmount'] as num?,
      totalDiscount: json['totalDiscount'] as num?,
      terminalId: json['terminalId'] as String?,
      paymentModeId: json['paymentModeId'] as num?,
      totalOriginalPrice: json['totalOriginalPrice'] as num?,
      paymentModeName: json['paymentModeName'] as String?,
      totalAfterDiscount: json['totalAfterDiscount'] as num?,
      worker: json['worker'] as String?,
      customer: json['customer'] as String?,
      customerId: json['customerId'] as String?,
      customerPhoneNumber: json['customerPhoneNumber'] as String?,
      transactionUrl: json['transactionUrl'] as String?,
      param1Object: json['param1Object'] == null
          ? null
          : ParamObjectResponse.fromJson(
              json['param1Object'] as Map<String, dynamic>),
      param2Object: json['param2Object'] == null
          ? null
          : ParamObjectResponse.fromJson(
              json['param2Object'] as Map<String, dynamic>),
      param3Object: json['param3Object'] == null
          ? null
          : ParamObjectResponse.fromJson(
              json['param3Object'] as Map<String, dynamic>),
      isClaimed: json['isClaimed'] as bool?,
      cashier: json['cashier'] as String?,
    );

Map<String, dynamic> _$TransactionDataResponseToJson(
        TransactionDataResponse instance) =>
    <String, dynamic>{
      'transactionMasterId': instance.transactionMasterId,
      'offlineTransactionId': instance.offlineTransactionId,
      'transactionDateTime': instance.transactionDateTime,
      'voucherNO': instance.voucherNO,
      'isClaimed': instance.isClaimed,
      'couponCode': instance.couponCode,
      'discountType': instance.discountType,
      'transactionUrl': instance.transactionUrl,
      'discountValue': instance.discountValue,
      'totalAmount': instance.totalAmount,
      'totalTaxAmount': instance.totalTaxAmount,
      'totalDiscount': instance.totalDiscount,
      'terminalId': instance.terminalId,
      'paymentModeId': instance.paymentModeId,
      'totalOriginalPrice': instance.totalOriginalPrice,
      'totalAfterDiscount': instance.totalAfterDiscount,
      'cashier': instance.cashier,
      'customer': instance.customer,
      'customerId': instance.customerId,
      'customerPhoneNumber': instance.customerPhoneNumber,
      'paymentModeName': instance.paymentModeName,
      'worker': instance.worker,
      'deliveryDiscountPrice': instance.deliveryDiscountPrice,
      'deliveryFinalPrice': instance.deliveryFinalPrice,
      'param1Object': instance.param1Object,
      'param2Object': instance.param2Object,
      'param3Object': instance.param3Object,
    };
