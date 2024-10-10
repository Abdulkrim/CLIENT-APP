import 'package:merchant_dashboard/feature/dashboard/data/models/params/merchant_branch_parameter.dart';

class GetCashiersParameter extends MerchantBranchParameter {
  final bool isOnlyActiveItems;

  GetCashiersParameter({this.isOnlyActiveItems = false});

  Map<String, dynamic> toJson() => {
        ...?super.branchToJson(),
        'isActive': isOnlyActiveItems,
      };
}
