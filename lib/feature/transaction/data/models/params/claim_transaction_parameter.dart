class ClaimTransactionParameter {
  final int transactionMasterId;
  final List<int>? transactionDetailsIds;

  ClaimTransactionParameter({
    required this.transactionMasterId,
    this.transactionDetailsIds,
  });

  Map<String, dynamic> toJson() => {
        'TransactionId': transactionMasterId,
      };
}
