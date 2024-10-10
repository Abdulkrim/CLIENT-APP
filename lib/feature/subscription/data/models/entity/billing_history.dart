
import '../../../../../utils/mixins/date_time_utilities.dart';

class BillingHistory {
  final int currentPageNumber;
  final int totalPageCount;

  final List<BillingHistoryItem> billings;

  BillingHistory({required this.currentPageNumber, required this.totalPageCount, required this.billings});
}

class BillingHistoryItem with DateTimeUtilities {
  final String id;
  final String currency;
  final num amount;
  final String branchSubscription;
  final String _paidOn;
  String get paidOn => convertDateFormat(_paidOn);
  final String paymentModeName;
  final String referenceNumber;
  final String paymentStatusName;
  final String downloadUrl;

  bool get isPending => paymentStatusName.toLowerCase() == 'pending';
  bool get isCompleted => paymentStatusName.toLowerCase() == 'completed';
  final String invoiceId;

  BillingHistoryItem({
    required this.id,
    required this.currency,
    required this.amount,
    required this.branchSubscription,
    required String paidOn,
    required this.paymentModeName,
    required this.referenceNumber,
    required this.downloadUrl,
    required this.paymentStatusName,
    required this.invoiceId,
  }) : _paidOn = paidOn;
}
