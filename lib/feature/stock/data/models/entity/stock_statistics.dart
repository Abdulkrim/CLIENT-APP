import 'package:equatable/equatable.dart';

class StockStatistics extends Equatable {
  final String totalItems;
  final String totalQuantity;
  final String totalValue;

  const StockStatistics({required this.totalItems, required this.totalQuantity, required this.totalValue});

  @override
  List<Object> get props => [totalItems, totalQuantity, totalValue];
}
