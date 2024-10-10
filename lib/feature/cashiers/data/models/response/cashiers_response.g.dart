// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cashiers_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CashiersResponse _$CashiersResponseFromJson(Map<String, dynamic> json) =>
    CashiersResponse(
      data: (json['value'] as List<dynamic>?)
              ?.map((e) =>
                  CashierInfoResponse.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      currentPageNumber: (json['currentPageNumber'] as num?)?.toInt(),
      totalPageCount: (json['totalPageCount'] as num?)?.toInt(),
      message: json['message'] as String?,
      statusCode: (json['statusCode'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CashiersResponseToJson(CashiersResponse instance) =>
    <String, dynamic>{
      'value': instance.data,
      'currentPageNumber': instance.currentPageNumber,
      'totalPageCount': instance.totalPageCount,
      'message': instance.message,
      'statusCode': instance.statusCode,
    };
