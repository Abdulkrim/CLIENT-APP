import 'package:equatable/equatable.dart';

class ExpenseType extends Equatable {
  final int id;
  final String name;

  const ExpenseType(this.id, this.name);

  @override
  List<Object> get props => [id, name];
}
