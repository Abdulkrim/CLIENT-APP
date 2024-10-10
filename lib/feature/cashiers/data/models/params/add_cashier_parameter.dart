import 'package:merchant_dashboard/feature/dashboard/data/models/params/merchant_branch_parameter.dart';

class AddCashierParameter extends MerchantBranchParameter {
  final String name;
  final String password;
  final int roleId;

  AddCashierParameter({required this.name, required this.password, required this.roleId});

  Map<String, dynamic> toJson() => {
        ...?super.branchToJson(),
        "cashierName": name,
        "cashierPassword": password,
        "posRoleId": roleId,
      };
}
