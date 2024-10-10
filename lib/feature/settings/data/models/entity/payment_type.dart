import 'package:equatable/equatable.dart';

class PaymentType extends Equatable {
  final int id;
  final String name;
  final bool canHaveReference;
  final bool isDefault;

  num amount = 0;
  String reference = '';

  PaymentType({required this.id, required this.name, this.canHaveReference = false,required this.isDefault });

  @override
  List<Object?> get props => [id, name, canHaveReference, isDefault];
}
