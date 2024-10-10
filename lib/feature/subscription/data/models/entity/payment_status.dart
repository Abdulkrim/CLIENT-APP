class PaymentStatus {
  final String id;
  final String currency;
  final num amount;
  final String branchName;
  final String paidOn;
  final String invoiceId;
  final String referenceNumber;
  final String paymentStatus;

  bool get isSuccess => paymentStatus.toLowerCase() == 'completed';
  bool get isValidStatus => paymentStatus.toLowerCase() == 'completed' || paymentStatus.toLowerCase() == 'failed'  ;

  PaymentStatus({
    required this.id,
    required this.currency,
    required this.branchName,
    required this.amount,
    required this.invoiceId,
    required this.paidOn,
    required this.referenceNumber,
    required this.paymentStatus,
  });
}
