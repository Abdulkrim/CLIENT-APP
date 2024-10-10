class TransactionDetailsParameter {
  final int transactionMasterId;

  TransactionDetailsParameter({
    required this.transactionMasterId,
  });

  Map<String, dynamic> toJson() => {
        'transactionMasterId': transactionMasterId,
      };
}
