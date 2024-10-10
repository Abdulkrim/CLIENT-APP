import 'package:equatable/equatable.dart';

import '../../../../settings/data/models/entity/payment_type.dart';

class PaymentSettings extends Equatable {
  final int claimAllowed;
  final List<PaymentType> payment;
  final bool customerAllowed;
  final bool taxAllowed;
  final int trn;

  final int taxTypeId;

  const PaymentSettings({
    required this.claimAllowed,
    required this.payment,
    required this.customerAllowed,
    required this.taxAllowed,
    required this.trn,
    required this.taxTypeId,
  });

  @override
  List<Object> get props => [
        claimAllowed,
        payment,
        customerAllowed,
        taxAllowed,
        trn,
        taxTypeId,
      ];
}
