import 'package:merchant_dashboard/feature/dashboard/data/models/params/merchant_branch_parameter.dart';

class GetBranchShiftParameter extends MerchantBranchParameter {
  final int workType;

  GetBranchShiftParameter({required this.workType});

  Map<String, dynamic> toJson() => {
        ...?super.branchToJson(),
        'workingType': workType,
      };
}
