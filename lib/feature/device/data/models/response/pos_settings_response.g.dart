// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pos_settings_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PosSettingsResponse _$PosSettingsResponseFromJson(Map<String, dynamic> json) =>
    PosSettingsResponse(
      queueAllowed: (json['queueAllowed'] as num?)?.toInt(),
      posOrderPrintType: $enumDecodeNullable(
          _$PrintOrderOptionsEnumEnumMap, json['posOrderPrintType']),
      posTransactionPrintType: $enumDecodeNullable(
          _$PrintTrxOptionsEnumEnumMap, json['posTransactionPrintType']),
      discountAllowed: (json['discountAllowed'] as num?)?.toInt(),
      branchID: json['branchID'] as String?,
      printAllowed: json['printAllowed'] as bool?,
      footerMessage: json['footerMessage'] as String?,
      rePrint: json['rePrint'] as bool?,
      merchantCopy: (json['merchantCopy'] as num?)?.toInt(),
      printingLogoLink: json['printingLogoLink'] as String?,
      footerLogoLink: json['footerLogoLink'] as String?,
      queueAllowedString: json['queueAllowedString'] as String?,
      discountAllowedString: json['discountAllowedString'] as String?,
      merchantCopyString: json['merchantCopyString'] as String?,
    );

Map<String, dynamic> _$PosSettingsResponseToJson(
        PosSettingsResponse instance) =>
    <String, dynamic>{
      'queueAllowed': instance.queueAllowed,
      'discountAllowed': instance.discountAllowed,
      'branchID': instance.branchID,
      'printAllowed': instance.printAllowed,
      'footerMessage': instance.footerMessage,
      'rePrint': instance.rePrint,
      'merchantCopy': instance.merchantCopy,
      'printingLogoLink': instance.printingLogoLink,
      'footerLogoLink': instance.footerLogoLink,
      'queueAllowedString': instance.queueAllowedString,
      'discountAllowedString': instance.discountAllowedString,
      'merchantCopyString': instance.merchantCopyString,
      'posOrderPrintType':
          _$PrintOrderOptionsEnumEnumMap[instance.posOrderPrintType],
      'posTransactionPrintType':
          _$PrintTrxOptionsEnumEnumMap[instance.posTransactionPrintType],
    };

const _$PrintOrderOptionsEnumEnumMap = {
  PrintOrderOptionsEnum.bothCloudAndPOS: 0,
  PrintOrderOptionsEnum.onlyCloud: 1,
  PrintOrderOptionsEnum.onlyPOS: 2,
  PrintOrderOptionsEnum.none: 3,
};

const _$PrintTrxOptionsEnumEnumMap = {
  PrintTrxOptionsEnum.bothCloudAndPOS: 0,
  PrintTrxOptionsEnum.onlyCloud: 1,
  PrintTrxOptionsEnum.onlyPOS: 2,
  PrintTrxOptionsEnum.none: 3,
};
