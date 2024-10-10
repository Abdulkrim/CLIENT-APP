import 'package:equatable/equatable.dart';

class BranchParameters extends Equatable {
  final bool? customerAllowed;
  final bool taxAllowed;

  final int trn;
  final int taxID;
  final int taxTypeId;

  const BranchParameters({
    required this.customerAllowed,
    required this.taxAllowed,
    required this.trn,
    required this.taxID,
    required this.taxTypeId,
  });

  @override
  List<Object?> get props => [
        customerAllowed,
        taxAllowed,
        trn,
        taxID,
        taxTypeId,
      ];
}
