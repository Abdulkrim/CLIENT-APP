// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionDetailsResponse _$TransactionDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    TransactionDetailsResponse(
      transactionDate: json['transactionDate'] as String?,
      branchName: json['branchName'] as String?,
      subcategoryName: json['subcategoryName'] as String?,
      categoryName: json['categoryName'] as String?,
      transactionDetailId: (json['transactionDetailId'] as num?)?.toInt(),
      qty: (json['qty'] as num?)?.toInt(),
      taxRate: json['taxRate'] as num?,
      worker: json['worker'] as String?,
      taxAmount: json['taxAmount'] as num?,
      facevalue: json['facevalue'] as num?,
      discount: json['discount'] as num?,
      itemId: (json['itemId'] as num?)?.toInt(),
      totallPrice: json['totallPrice'] as num?,
      itemName: json['itemName'] as String?,
    );

Map<String, dynamic> _$TransactionDetailsResponseToJson(
        TransactionDetailsResponse instance) =>
    <String, dynamic>{
      'transactionDate': instance.transactionDate,
      'branchName': instance.branchName,
      'transactionDetailId': instance.transactionDetailId,
      'qty': instance.qty,
      'taxRate': instance.taxRate,
      'taxAmount': instance.taxAmount,
      'facevalue': instance.facevalue,
      'discount': instance.discount,
      'itemId': instance.itemId,
      'itemName': instance.itemName,
      'subcategoryName': instance.subcategoryName,
      'categoryName': instance.categoryName,
      'worker': instance.worker,
      'totallPrice': instance.totallPrice,
    };
