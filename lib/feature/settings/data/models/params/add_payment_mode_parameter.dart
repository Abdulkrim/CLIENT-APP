import 'package:merchant_dashboard/feature/dashboard/data/models/params/merchant_branch_parameter.dart';

class AddPaymentModeParameter extends MerchantBranchParameter {
  final String name;
  final bool canHaveRefrence;

  AddPaymentModeParameter({required this.name, required this.canHaveRefrence});

  Map<String, dynamic> toJson() => {
        ...?super.branchToJson(),
        'name': name,
        'canHaveReference': canHaveRefrence,
      };
}
