// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workers_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkersResponse _$WorkersResponseFromJson(Map<String, dynamic> json) =>
    WorkersResponse(
      value: (json['value'] as List<dynamic>?)
          ?.map((e) => WorkerItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentPageNumber: (json['currentPageNumber'] as num?)?.toInt(),
      totalPageCount: (json['totalPageCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$WorkersResponseToJson(WorkersResponse instance) =>
    <String, dynamic>{
      'value': instance.value,
      'currentPageNumber': instance.currentPageNumber,
      'totalPageCount': instance.totalPageCount,
    };
