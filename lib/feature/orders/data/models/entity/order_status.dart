import 'package:equatable/equatable.dart';

import 'order_status_filter.dart';

class OrderStatus extends Equatable {
  final int id;
  final String name;
  final bool isCompleted;

  const OrderStatus(this.id, this.name, this.isCompleted);

  @override
  List<Object> get props => [id, name, isCompleted];
}

extension ToFilter on List<OrderStatus> {
  List<OrderStatusFilter> toFilterMode() =>
      [const OrderStatusFilter.firstItem(), ...map((e) => OrderStatusFilter(id: e.id, name: e.name)).toList()];
}
