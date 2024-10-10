import 'package:merchant_dashboard/feature/dashboard/data/models/params/merchant_branch_parameter.dart';

class AddTableParameter extends MerchantBranchParameter {
  final String tableName;
  final String tableCapacity;
  final String tableNumber;

  AddTableParameter({required this.tableCapacity, required this.tableName, required this.tableNumber});

  Map<String, dynamic> toJson() => {
        ...?super.branchToJson(),
        "tableNumber": int.parse(tableNumber),
        "tableName": tableName,
        "tableCapacity": int.parse(tableCapacity)
      };
}
