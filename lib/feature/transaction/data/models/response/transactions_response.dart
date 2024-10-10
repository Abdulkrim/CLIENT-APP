import 'package:json_annotation/json_annotation.dart';
import 'package:merchant_dashboard/feature/transaction/data/models/entity/transaction.dart';

import '../../../../orders/data/models/entity/param_object.dart';
import 'transaction_data_response.dart';

part 'transactions_response.g.dart';

@JsonSerializable()
class TransactionsResponse {
  @JsonKey(name: 'value')
  List<TransactionDataResponse> transactions;
  int? currentPageNumber;
  int? totalPageCount;

  TransactionsResponse({this.transactions = const [], this.currentPageNumber, this.totalPageCount});

  factory TransactionsResponse.fromJson(Map<String, dynamic> json) => _$TransactionsResponseFromJson(json);

  TransactionListInfo toEntity() => TransactionListInfo(
      currentPageNumber: currentPageNumber ?? 1,
      totalPageCount: totalPageCount ?? 1,
      transactions: transactions
          .map((e) => Transaction(
                userName: e.cashier ?? '-',
                customerName: e.customer ?? '',
                customerId: e.customerId ?? '-',
                isClaimed: e.isClaimed ?? false,
                customerPhoneNumber: e.customerPhoneNumber ?? '',
                transactionNo: e.transactionMasterId ?? 0,
                offlineTransactionId: (e.offlineTransactionId ?? '').toString(),
                discountAmount: e.totalDiscount ?? 0,
                voucher: e.voucherNO ?? 0,
                date: e.transactionDateTime ?? '',
                payment: e.paymentModeName ?? '',
                total: e.totalAmount ?? 0,
                tax: e.totalTaxAmount ?? 0,
                deliveryDiscountPrice: e.deliveryDiscountPrice ?? 0,
                deliveryFinalPrice: e.deliveryFinalPrice ?? 0,
                price: e.totalOriginalPrice ?? 0,
                worker: e.worker ?? '',
                transactionUrl: e.transactionUrl ?? '',
                param1Object: ParamObject(e.param1Object?.paramHeader ?? '', e.param1Object?.paramValue ?? '',
                    e.param1Object?.isEnabled ?? 'false'),
                param2Object: ParamObject(e.param2Object?.paramHeader ?? '', e.param2Object?.paramValue ?? '',
                    e.param2Object?.isEnabled ?? 'false'),
                param3Object: ParamObject(e.param3Object?.paramHeader ?? '', e.param3Object?.paramValue ?? '',
                    e.param3Object?.isEnabled ?? 'false'),
              ))
          .toList());
}
