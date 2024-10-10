import 'package:merchant_dashboard/feature/dashboard/data/models/params/merchant_branch_parameter.dart';

class EditWorkerParameter extends MerchantBranchParameter {
  final String fullName;
  final String workerId;
  final bool isActive;

  EditWorkerParameter({required this.fullName, required this.workerId, required this.isActive});

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "workerId": workerId,
        "isActive": isActive,
      };
}
