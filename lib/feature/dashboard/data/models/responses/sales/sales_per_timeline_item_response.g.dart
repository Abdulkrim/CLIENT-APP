// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_per_timeline_item_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalesPerTimelineItemResponse _$SalesPerTimelineItemResponseFromJson(
        Map<String, dynamic> json) =>
    SalesPerTimelineItemResponse(
      sumPrice: json['sumPrice'] as num?,
      date: json['date'] as String?,
      weekDay: json['weekDay'] as String?,
      count: (json['count'] as num?)?.toInt(),
      interval: json['interval'] as String?,
      day: json['day'] as String?,
      hour: (json['hour'] as num?)?.toInt(),
      weekNumber: (json['weekNumber'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SalesPerTimelineItemResponseToJson(
        SalesPerTimelineItemResponse instance) =>
    <String, dynamic>{
      'sumPrice': instance.sumPrice,
      'date': instance.date,
      'weekDay': instance.weekDay,
      'count': instance.count,
      'interval': instance.interval,
      'day': instance.day,
      'hour': instance.hour,
      'weekNumber': instance.weekNumber,
    };
