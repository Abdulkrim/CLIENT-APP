import 'package:merchant_dashboard/feature/dashboard/data/models/params/merchant_branch_parameter.dart';

class EditAreaParameter extends MerchantBranchParameter {
  final int areaId;
  final num minimumOrderAmount;
  final num deliveryFee;
  final num? maxDeliveryDiscount;

  EditAreaParameter(
      {required this.areaId, required this.minimumOrderAmount, required this.deliveryFee, this.maxDeliveryDiscount});

  Map<String, dynamic> toJson() => {
        ...?super.branchToJson(),
        "branchAreaId": areaId,
        "minimumOrderAmount": minimumOrderAmount,
        "deliveryFee": deliveryFee,
        "maximumDeliveryDiscount": maxDeliveryDiscount ?? 0
      };
}
