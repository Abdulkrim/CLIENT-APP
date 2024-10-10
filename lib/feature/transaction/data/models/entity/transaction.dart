import 'package:merchant_dashboard/utils/mixins/date_time_utilities.dart';

import '../../../../orders/data/models/entity/param_object.dart';

class TransactionListInfo {
  final int currentPageNumber;
  final int totalPageCount;

  final List<Transaction> transactions;

  TransactionListInfo(
      {required this.currentPageNumber, required this.totalPageCount, required this.transactions});
}

class Transaction with DateTimeUtilities {
  final String userName;
  final String customerName;
  final String customerPhoneNumber;
  final String customerId;
  final int transactionNo;
  final num discountAmount;
  final num voucher;
  final String payment;
  final String worker;
  final String transactionUrl;
  final num total;
  final num tax;
  final num price;
  final num deliveryDiscountPrice;
  final num deliveryFinalPrice;
  final String offlineTransactionId;
  final bool isClaimed;
  final ParamObject param1Object;
  final ParamObject param2Object;
  final ParamObject param3Object;

  final String _date;
  String get date => convertDateFormat(_date);

  Transaction({
    required this.userName,
    required this.customerName,
    required this.customerId,
    required this.customerPhoneNumber,
    required this.transactionNo,
    required this.voucher,
    required String date,
    required this.payment,
    required this.deliveryFinalPrice,
    required this.deliveryDiscountPrice,
    required this.total,
    required this.tax,
    required this.price,
    required this.offlineTransactionId,
    required this.worker,
    required this.discountAmount,
    required this.isClaimed,
    required this.transactionUrl,
    required this.param1Object,
    required this.param2Object,
    required this.param3Object,
  }) : _date = date;
}
