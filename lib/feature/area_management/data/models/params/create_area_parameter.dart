import 'package:merchant_dashboard/feature/dashboard/data/models/params/merchant_branch_parameter.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

class CreateAreaParameter extends MerchantBranchParameter {
  final int? cityId;
  final String? cityName;
  final String? areaName;
  final int? areaId;
  final num minimumOrderAmount;
  final num deliveryFee;
  final num? maxDeliveryDiscount;

  CreateAreaParameter(
      {this.cityId,
      this.cityName,
      this.areaName,
      this.areaId,
      required this.minimumOrderAmount,
      required this.deliveryFee,
      this.maxDeliveryDiscount});

  Map<String, dynamic> toJson() => {
        ...?super.branchToJson(),
        if (cityName != null) "cityName": cityName,
        if (areaName != null) "areaName": areaName,
        if (cityId.isIdValid) "cityId": cityId,
        if (areaId.isIdValid) "areaId": areaId,
        "minimumOrderAmount": minimumOrderAmount,
        "deliveryFee": deliveryFee,
        "maximumDeliveryDiscount": maxDeliveryDiscount ?? 0
      };
}

