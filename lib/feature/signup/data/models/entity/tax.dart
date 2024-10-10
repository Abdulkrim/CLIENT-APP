import 'package:equatable/equatable.dart';

class Tax extends Equatable {
  final int id;
  final String name;
  final num value;

  const Tax(this.id, this.name, this.value);

  @override
  List<Object> get props => [id, name, value];
}
