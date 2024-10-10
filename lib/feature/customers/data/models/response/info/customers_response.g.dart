// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customers_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomersResponse _$CustomersResponseFromJson(Map<String, dynamic> json) =>
    CustomersResponse(
      customers: (json['value'] as List<dynamic>?)
          ?.map((e) => CustomerInfoResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentPageNumber: (json['currentPageNumber'] as num?)?.toInt(),
      totalPageCount: (json['totalPageCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CustomersResponseToJson(CustomersResponse instance) =>
    <String, dynamic>{
      'value': instance.customers,
      'currentPageNumber': instance.currentPageNumber,
      'totalPageCount': instance.totalPageCount,
    };
