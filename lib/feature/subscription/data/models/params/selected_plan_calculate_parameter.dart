import 'package:merchant_dashboard/feature/dashboard/data/models/params/merchant_branch_parameter.dart';

class SelectedPlanCalculateParameter extends MerchantBranchParameter {
  final int packageId;
  final List<int> addonItems;
  final int duration;
  final int payType;
  final int interval;

  SelectedPlanCalculateParameter({
    required this.packageId,
    required this.addonItems,
    required this.duration,
    required this.interval,
    this.payType =2,
  });

  Map<String, dynamic> toJson() => {
        ...?super.branchToJson(),
        "packageId": packageId,
        "additionalFeatures": addonItems,
        "duration": duration,
        "interval": interval,
        "paymentType": payType
      };
}
