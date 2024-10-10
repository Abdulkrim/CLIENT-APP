import 'package:merchant_dashboard/feature/dashboard/data/models/params/merchant_branch_parameter.dart';

class AddWorkerParameter extends MerchantBranchParameter {
  final String fullName;

  AddWorkerParameter({required this.fullName});

  Map<String, dynamic> toJson() => {
        ...?super.branchToJson(),
        "fullName": fullName,
      };
}
