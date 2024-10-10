// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactions_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionsResponse _$TransactionsResponseFromJson(
        Map<String, dynamic> json) =>
    TransactionsResponse(
      transactions: (json['value'] as List<dynamic>?)
              ?.map((e) =>
                  TransactionDataResponse.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      currentPageNumber: (json['currentPageNumber'] as num?)?.toInt(),
      totalPageCount: (json['totalPageCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TransactionsResponseToJson(
        TransactionsResponse instance) =>
    <String, dynamic>{
      'value': instance.transactions,
      'currentPageNumber': instance.currentPageNumber,
      'totalPageCount': instance.totalPageCount,
    };
