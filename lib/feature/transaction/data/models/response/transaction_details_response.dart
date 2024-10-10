import 'package:json_annotation/json_annotation.dart';
import 'package:merchant_dashboard/feature/transaction/data/models/entity/transaction_details.dart';

part 'transaction_details_response.g.dart';

@JsonSerializable()
class TransactionDetailsResponse {
  String? transactionDate;
  String? branchName;
  int? transactionDetailId;
  int? qty;
  num? taxRate;
  num? taxAmount;
  num? facevalue;
  num? discount;
  int? itemId;
  String? itemName;
  String? subcategoryName;
  String? categoryName;
  String? worker;
  num? totallPrice;

  TransactionDetailsResponse(
      {this.transactionDate,
      this.branchName,
      this.subcategoryName,
      this.categoryName,
      this.transactionDetailId,
      this.qty,
      this.taxRate,
      this.worker,
      this.taxAmount,
      this.facevalue,
      this.discount,
      this.itemId,
      this.totallPrice,
      this.itemName});

  factory TransactionDetailsResponse.fromJson(Map<String, dynamic> json) => _$TransactionDetailsResponseFromJson(json);
}

class TransactionDetailsDataResponse {
  List<TransactionDetailsResponse>? transactionDetails;
  String? message;
  int? statusCode;
  bool? isSucceeded;

  TransactionDetailsDataResponse({this.transactionDetails, this.message, this.statusCode, this.isSucceeded});

  TransactionDetailsDataResponse.fromJson(Map<String, dynamic> json)
      : transactionDetails = (json['transactionDetails'] as List<dynamic>?)?.map((e) => TransactionDetailsResponse.fromJson(e)).toList() ?? [],
        message = json['message'] as String,
        statusCode = json['statusCode'] as int,
        isSucceeded = json['isSucceeded'] as bool;

  List<TransactionDetails> toEntity() =>
      transactionDetails
          ?.map((e) => TransactionDetails(
              productName: e.itemName ?? '',
              category: e.categoryName ?? '-',
              subCategory: e.subcategoryName ?? '-',
              productId: e.itemId ?? 0,
              productType: '',
              quantity: e.qty ?? 0,
              price: e.facevalue ?? 0,
              total: e.totallPrice ?? 0,
              worker: e.worker ?? ''))
          .toList() ??
      [];
}
