import 'package:equatable/equatable.dart';

class SalesStatistics extends Equatable{
  final List<PaymentStatsItem> paymentStats;
  final num totalPrice;
  final int totalCount;

  const SalesStatistics(this.paymentStats, this.totalPrice, this.totalCount);

  @override
  List<Object> get props => [paymentStats , totalCount, totalPrice];
}

class PaymentStatsItem extends Equatable {
  final num sumPrice;
  final String paymentType;

  const PaymentStatsItem({required this.sumPrice, required this.paymentType});

  @override
  List<Object> get props => [sumPrice , paymentType];
}
