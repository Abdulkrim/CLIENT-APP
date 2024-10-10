class OrderProduct {
  final String id;
  final num originalPrice;
  final String itemNameEN;
  final String itemNameAR;
  final String itemNameTR;
  final String itemNameFR;
  final num quantity;

  OrderProduct({
    required this.id,
    required this.originalPrice,
    required this.itemNameEN,
    required this.itemNameAR,
    required this.itemNameFR,
    required this.itemNameTR,
    required this.quantity,
  });
}
