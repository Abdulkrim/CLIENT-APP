// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parameter_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParameterResponse _$ParameterResponseFromJson(Map<String, dynamic> json) =>
    ParameterResponse(
      branchParamID: json['branchParamID'] as String?,
      customerAllowed: json['customerAllowed'] as bool?,
      queueAllowed: (json['queueAllowed'] as num?)?.toInt(),
      discountAllowed: (json['discountAllowed'] as num?)?.toInt(),
      claimAllowed: (json['claimAllowed'] as num?)?.toInt(),
      businessDayAllowed: (json['businessDayAllowed'] as num?)?.toInt(),
      businessShiftAllowed: json['businessShiftAllowed'] as bool?,
      branchPaymentModes: json['branchPaymentModes'] == null
          ? null
          : PaymentTypesResponse.fromJson(
              json['branchPaymentModes'] as List<dynamic>?),
      taxAllowed: json['taxAllowed'] as bool?,
      smsAllowed: json['smsAllowed'] as bool?,
      trn: (json['trn'] as num?)?.toInt(),
      decimalPoint: (json['decimalPoint'] as num?)?.toInt(),
      nfcProductSearch: json['nfcProductSearch'] as bool?,
      taxID: (json['taxID'] as num?)?.toInt(),
      branchID: json['branchID'] as String?,
      taxTypeId: (json['taxTypeId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ParameterResponseToJson(ParameterResponse instance) =>
    <String, dynamic>{
      'branchParamID': instance.branchParamID,
      'customerAllowed': instance.customerAllowed,
      'queueAllowed': instance.queueAllowed,
      'discountAllowed': instance.discountAllowed,
      'businessDayAllowed': instance.businessDayAllowed,
      'businessShiftAllowed': instance.businessShiftAllowed,
      'branchPaymentModes': instance.branchPaymentModes,
      'claimAllowed': instance.claimAllowed,
      'taxAllowed': instance.taxAllowed,
      'smsAllowed': instance.smsAllowed,
      'trn': instance.trn,
      'decimalPoint': instance.decimalPoint,
      'nfcProductSearch': instance.nfcProductSearch,
      'taxID': instance.taxID,
      'branchID': instance.branchID,
      'taxTypeId': instance.taxTypeId,
    };
