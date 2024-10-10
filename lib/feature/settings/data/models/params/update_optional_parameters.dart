import 'package:merchant_dashboard/feature/dashboard/data/models/params/merchant_branch_parameter.dart';

class UpdateOptionalParameters extends MerchantBranchParameter {
  final Map<String, String> keyValues;

  UpdateOptionalParameters({required this.keyValues});

  Map<String, dynamic> toJson() => {
        "branchId": super.branchId.isEmpty ? null : super.branchId,
        "keyValues": keyValues,
      };
}
