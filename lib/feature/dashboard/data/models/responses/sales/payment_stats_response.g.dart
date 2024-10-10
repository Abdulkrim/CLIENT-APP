// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_stats_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentStatsResponse _$PaymentStatsResponseFromJson(
        Map<String, dynamic> json) =>
    PaymentStatsResponse(
      sumPrice: json['sumPrice'] as num?,
      paymentType: json['paymentType'] as String?,
      paymentTypeId: (json['paymentTypeId'] as num?)?.toInt(),
      count: (json['count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PaymentStatsResponseToJson(
        PaymentStatsResponse instance) =>
    <String, dynamic>{
      'sumPrice': instance.sumPrice,
      'paymentType': instance.paymentType,
      'paymentTypeId': instance.paymentTypeId,
      'count': instance.count,
    };
