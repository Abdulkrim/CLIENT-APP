import 'package:merchant_dashboard/feature/orders/data/models/entity/order_statistics.dart';

class OrderStatisticsResponse {
  num? sumPrices;
  num? ordersCount;
  num? customerCount;
  num? customerSumPrices;
  num? productsSumPrices;
  num? productsCount;

  OrderStatisticsResponse({this.sumPrices,
    this.ordersCount,
    this.customerCount,
    this.customerSumPrices,
    this.productsSumPrices,
    this.productsCount});

  OrderStatisticsResponse.fromJson(Map<String, dynamic> json) {
    sumPrices = json['sumPrices'];
    ordersCount = json['ordersCount'];
    customerCount = json['customerCount'];
    customerSumPrices = json['customerSumPrices'];
    productsSumPrices = json['productsSumPrices'];
    productsCount = json['productsCount'];
  }


  OrderStatistics toEntity() =>
      OrderStatistics(sumPrices: sumPrices ?? 0,
          ordersCount: ordersCount ?? 0,
          customerCount: customerCount ?? 0,
          customerSumPrices: customerSumPrices ?? 0,
          productsCount: productsCount ?? 0,
          productsSumPrices: productsSumPrices ?? 0);
}