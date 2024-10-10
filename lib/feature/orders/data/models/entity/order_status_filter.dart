
import 'package:equatable/equatable.dart';

class OrderStatusFilter extends Equatable {
  final int id;
  final String name;

  const OrderStatusFilter({required this.id, required this.name});

  const OrderStatusFilter.firstItem()
      : id = 0,
        name = 'Select Order Status';

  @override
  List<Object> get props => [id, name];
}