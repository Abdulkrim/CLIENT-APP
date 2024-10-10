// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_statistics_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalesStatisticsResponse _$SalesStatisticsResponseFromJson(
        Map<String, dynamic> json) =>
    SalesStatisticsResponse(
      paymentStats: (json['paymentStats'] as List<dynamic>?)
          ?.map((e) => PaymentStatsResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPrice: json['totalPrice'] as num?,
      totalCount: (json['totalCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SalesStatisticsResponseToJson(
        SalesStatisticsResponse instance) =>
    <String, dynamic>{
      'paymentStats': instance.paymentStats,
      'totalPrice': instance.totalPrice,
      'totalCount': instance.totalCount,
    };
