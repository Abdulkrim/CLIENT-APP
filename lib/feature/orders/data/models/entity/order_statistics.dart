class OrderStatistics {
  final num sumPrices;
  final num ordersCount;
  final num customerCount;
  final num customerSumPrices;
  final num productsSumPrices;
  final num productsCount;

  OrderStatistics(
      {required this.sumPrices,
      required this.ordersCount,
      required this.customerCount,
      required this.customerSumPrices,
      required this.productsCount,
      required this.productsSumPrices});
}
