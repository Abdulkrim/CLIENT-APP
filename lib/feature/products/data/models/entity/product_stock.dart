import 'package:equatable/equatable.dart';
import 'package:merchant_dashboard/feature/products/data/models/entity/measure_unit.dart';

class ProductStock extends Equatable {
  final int id;
  final int quantity;
  final int stockStatus;
  final MeasureUnit? measureUnit;

  const ProductStock({required this.id, required this.quantity, required this.stockStatus, this.measureUnit});

  @override
  List<Object> get props => [id, quantity, stockStatus];
}
