import 'package:merchant_dashboard/feature/dashboard/data/models/params/merchant_branch_parameter.dart';

class DeleteAreaParameter extends MerchantBranchParameter {
  final int areaId;

  DeleteAreaParameter({required this.areaId});

  Map<String, dynamic> toJson() => {
        ...?super.branchToJson(),
        "id": areaId,
      };
}
