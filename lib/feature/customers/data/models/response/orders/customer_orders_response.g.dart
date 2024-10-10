// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_orders_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerOrdersResponse _$CustomerOrdersResponseFromJson(
        Map<String, dynamic> json) =>
    CustomerOrdersResponse(
      value: (json['value'] as List<dynamic>?)
          ?.map((e) =>
              CustomerOrderValueResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentPageNumber: (json['currentPageNumber'] as num?)?.toInt(),
      pageSize: (json['pageSize'] as num?)?.toInt(),
      totalPageCount: (json['totalPageCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CustomerOrdersResponseToJson(
        CustomerOrdersResponse instance) =>
    <String, dynamic>{
      'value': instance.value,
      'currentPageNumber': instance.currentPageNumber,
      'pageSize': instance.pageSize,
      'totalPageCount': instance.totalPageCount,
    };
