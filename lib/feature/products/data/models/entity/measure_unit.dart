import 'package:equatable/equatable.dart';

class MeasureUnit extends Equatable {
  final int id;
  final String name;
  final String symbol;

  const MeasureUnit({required this.id, required this.name, required this.symbol});

  @override
  List<Object> get props => [id, name, symbol];
}
