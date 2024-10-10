class IncreaseStockParameter {
  final int itemId;
  final num amount;
  final int unitOfMeasureId;
  final num pricePerUnit;

  IncreaseStockParameter(
      {required this.amount,
      required this.itemId,
      required this.pricePerUnit,
      required this.unitOfMeasureId});

  Map<String, dynamic> toJson() =>
      {"itemId": itemId, "amount": amount, "unitOfMeasureId": unitOfMeasureId, "pricePerUnit": pricePerUnit};
}
