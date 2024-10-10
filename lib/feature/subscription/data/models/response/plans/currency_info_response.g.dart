// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrencyInfoResponse _$CurrencyInfoResponseFromJson(
        Map<String, dynamic> json) =>
    CurrencyInfoResponse(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      symbol: json['symbol'] as String?,
    );

Map<String, dynamic> _$CurrencyInfoResponseToJson(
        CurrencyInfoResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'symbol': instance.symbol,
    };
