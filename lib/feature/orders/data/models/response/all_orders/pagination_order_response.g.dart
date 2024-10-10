// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationOrderResponse _$PaginationOrderResponseFromJson(
        Map<String, dynamic> json) =>
    PaginationOrderResponse(
      value: (json['value'] as List<dynamic>?)
          ?.map((e) => OrderItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentPageNumber: (json['currentPageNumber'] as num?)?.toInt(),
      pageSize: (json['pageSize'] as num?)?.toInt(),
      totalPageCount: (json['totalPageCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PaginationOrderResponseToJson(
        PaginationOrderResponse instance) =>
    <String, dynamic>{
      'value': instance.value,
      'currentPageNumber': instance.currentPageNumber,
      'pageSize': instance.pageSize,
      'totalPageCount': instance.totalPageCount,
    };
