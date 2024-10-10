import 'package:json_annotation/json_annotation.dart';
import 'package:merchant_dashboard/feature/subscription/data/models/entity/billing_history.dart';

import 'billing_history_item_response.dart';

part 'billing_history_list_response.g.dart';

@JsonSerializable()
class BillingHistoryListResponse {
  List<BillingHistoryItemResponse>? value;
  int? currentPageNumber;
  int? pageSize;
  int? totalPageCount;

  BillingHistoryListResponse({this.value, this.currentPageNumber, this.pageSize, this.totalPageCount});

  factory BillingHistoryListResponse.fromJson(Map<String, dynamic> json) =>
      _$BillingHistoryListResponseFromJson(json);

  BillingHistory toEntity() => BillingHistory(
      currentPageNumber: currentPageNumber ?? 1,
      totalPageCount: totalPageCount ?? 1,
      billings: value
              ?.map((e) => BillingHistoryItem(
                  id: e.id ?? '',
                  currency: e.currency?.name ?? '',
                  downloadUrl: e.downloadUrl ?? '',
                  amount: e.amount ?? 0,
                  branchSubscription: e.branch?.name ?? '',
                  paidOn: e.paidOn ?? '',
                  paymentModeName: e.paymentMode?.paymentModeName ?? '',
                  referenceNumber: e.referenceNumber ?? '',
                  paymentStatusName: e.paymentStatus?.name ?? '',
                  invoiceId: e.invoiceId ?? ''))
              .toList() ??
          []);
}
