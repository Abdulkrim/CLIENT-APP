// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_settings_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentSettingsResponse _$PaymentSettingsResponseFromJson(
        Map<String, dynamic> json) =>
    PaymentSettingsResponse(
      claimAllowed: (json['claimAllowed'] as num?)?.toInt(),
      branchPaymentModes: (json['branchPaymentModes'] as List<dynamic>?)
          ?.map((e) =>
              PaymentTypeItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      claimAllowedString: json['claimAllowedString'] as String?,
      taxID: (json['taxID'] as num?)?.toInt(),
      taxAllowed: json['taxAllowed'] as bool?,
      customerAllowed: json['customerAllowed'] as bool?,
      taxTypeId: (json['taxTypeId'] as num?)?.toInt(),
      trn: json['trn'] as String?,
    );

Map<String, dynamic> _$PaymentSettingsResponseToJson(
        PaymentSettingsResponse instance) =>
    <String, dynamic>{
      'claimAllowed': instance.claimAllowed,
      'branchPaymentModes': instance.branchPaymentModes,
      'claimAllowedString': instance.claimAllowedString,
      'customerAllowed': instance.customerAllowed,
      'taxAllowed': instance.taxAllowed,
      'trn': instance.trn,
      'taxID': instance.taxID,
      'taxTypeId': instance.taxTypeId,
    };
