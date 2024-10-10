import 'package:merchant_dashboard/feature/dashboard/data/models/params/merchant_branch_parameter.dart';

class EditTableParameter extends MerchantBranchParameter {
  final int tableId;
  final String tableName;
  final String tableCapacity;
  final String tableNumber;

  EditTableParameter(
      {required this.tableId,
      required this.tableCapacity,
      required this.tableName,
      required this.tableNumber});

  Map<String, dynamic> toJson() => {
        ...?super.branchToJson(),
        "Id": tableId,
        "tableNumber": int.parse(tableNumber),
        "tableName": tableName,
        "tableCapacity": int.parse(tableCapacity)
      };
}
