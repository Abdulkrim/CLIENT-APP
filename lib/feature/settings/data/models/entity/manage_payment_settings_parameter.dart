import '../../../../dashboard/data/models/params/merchant_branch_parameter.dart';

class ManagePaymentSettingsParameter extends MerchantBranchParameter {
  final int claimAllowed;
  final List<int> payment;
  final bool customerAllowed;
  final bool taxAllowed;
  final int trn;
  final int taxTypeId;
  final int taxID;

  ManagePaymentSettingsParameter(
      {required this.claimAllowed,
      required this.payment,
      required this.customerAllowed,
      required this.taxID,
      required this.taxAllowed,
      required this.taxTypeId,
      required this.trn });

  Map<String, dynamic> toJson() => {
        ...?super.branchToJson(),
        "paymentModes": payment,
        "claimAllowed": claimAllowed,
        "CustomerAllowed": customerAllowed,
        "TaxAllowed": taxAllowed,
        "TRN": trn.toString(),
        "TaxTypeId": taxTypeId,
        "TaxID": taxID
      };
}
