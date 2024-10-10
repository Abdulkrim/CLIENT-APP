import 'package:equatable/equatable.dart';

class CashierFilter extends Equatable {
  final String id;
  final String name;

  const CashierFilter({required this.id, required this.name});

  const CashierFilter.firstItem()
      : id = '0',
        name = 'Select Cashier';

  @override
  List<Object> get props => [id, name];
}
