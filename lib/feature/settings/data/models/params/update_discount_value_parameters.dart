import 'package:merchant_dashboard/feature/dashboard/data/models/params/merchant_branch_parameter.dart';

class UpdateDiscountValueParameters extends MerchantBranchParameter{

  final int discountTypeValue;
  final num discountValue;

  UpdateDiscountValueParameters({required this.discountTypeValue  ,required this.discountValue  });

  Map<String, dynamic> toJson() => {
    ...?super.branchToJson(),
    'discountType': discountTypeValue ,
    'discountValue': discountValue,
  };
}