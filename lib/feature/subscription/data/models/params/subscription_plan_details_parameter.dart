import 'package:merchant_dashboard/feature/dashboard/data/models/params/merchant_branch_parameter.dart';

class SubscriptionPlanDetailsParameter extends MerchantBranchParameter {
  final int packageId;

  SubscriptionPlanDetailsParameter({required this.packageId});

  Map<String, dynamic> toJson() => {
        ...?super.branchToJson(),
        "packageId": packageId,
      };
}
