// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportResponse _$ReportResponseFromJson(Map<String, dynamic> json) =>
    ReportResponse(
      cashierName: json['cashierName'] as String?,
      cashierId: json['cashierId'] as String?,
      count: (json['count'] as num?)?.toInt(),
      sumPrice: json['sumPrice'] as num?,
    );

Map<String, dynamic> _$ReportResponseToJson(ReportResponse instance) =>
    <String, dynamic>{
      'cashierName': instance.cashierName,
      'cashierId': instance.cashierId,
      'count': instance.count,
      'sumPrice': instance.sumPrice,
    };
