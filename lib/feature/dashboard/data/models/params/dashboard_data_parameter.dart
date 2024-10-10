import 'package:merchant_dashboard/feature/dashboard/data/models/params/merchant_branch_parameter.dart';

class DashboardDataParameter extends MerchantBranchParameter {
  final String startDate;
  final String endDate;

  final String _branchId;

  final bool isBasedOnQuantity;

  DashboardDataParameter({this.startDate = '', this.endDate = '', String branchId = '', this.isBasedOnQuantity = false})
      : _branchId = branchId;

  Map<String, dynamic> toJson() => {
        if (startDate.isNotEmpty) 'from': startDate,
        if (endDate.isNotEmpty) 'to': endDate,
        ...?super.branchToJson(),
      };

  Map<String, dynamic> pieChartParametertToJson() => {
        if (startDate.isNotEmpty) 'from': startDate,
        if (endDate.isNotEmpty) 'to': endDate,
        ...?super.branchToJson(),
        'selectOn': (isBasedOnQuantity) ? 'Quantity' : 'FinalPrice'
      };
}
