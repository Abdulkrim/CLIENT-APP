// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockListResponse _$StockListResponseFromJson(Map<String, dynamic> json) =>
    StockListResponse(
      stocks: (json['value'] as List<dynamic>?)
          ?.map((e) => StockInfoResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentPageNumber: (json['currentPageNumber'] as num?)?.toInt(),
      pageSize: (json['pageSize'] as num?)?.toInt(),
      totalPageCount: (json['totalPageCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$StockListResponseToJson(StockListResponse instance) =>
    <String, dynamic>{
      'value': instance.stocks,
      'currentPageNumber': instance.currentPageNumber,
      'pageSize': instance.pageSize,
      'totalPageCount': instance.totalPageCount,
    };
