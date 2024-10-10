import 'package:merchant_dashboard/feature/dashboard/data/models/params/merchant_branch_parameter.dart';

class DeleteTableParameter extends MerchantBranchParameter {
  final int tableId;

  DeleteTableParameter({required this.tableId});

  Map<String, dynamic> toJson() => {
        ...?super.branchToJson(),
        "Id": tableId,
      };
}
