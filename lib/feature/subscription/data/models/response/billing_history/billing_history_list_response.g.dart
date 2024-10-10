// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'billing_history_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BillingHistoryListResponse _$BillingHistoryListResponseFromJson(
        Map<String, dynamic> json) =>
    BillingHistoryListResponse(
      value: (json['value'] as List<dynamic>?)
          ?.map((e) =>
              BillingHistoryItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentPageNumber: (json['currentPageNumber'] as num?)?.toInt(),
      pageSize: (json['pageSize'] as num?)?.toInt(),
      totalPageCount: (json['totalPageCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BillingHistoryListResponseToJson(
        BillingHistoryListResponse instance) =>
    <String, dynamic>{
      'value': instance.value,
      'currentPageNumber': instance.currentPageNumber,
      'pageSize': instance.pageSize,
      'totalPageCount': instance.totalPageCount,
    };
