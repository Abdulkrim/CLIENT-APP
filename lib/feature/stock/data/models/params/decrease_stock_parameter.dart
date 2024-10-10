class DecreaseStockParameter {
  final int itemId;
  final num amount;
  final int reasonId;

  DecreaseStockParameter({required this.amount, required this.itemId, required this.reasonId});

  Map<String, dynamic> toJson() => {
        "itemStockId": itemId,
        "amount": amount,
        "reason": reasonId,
      };
}
