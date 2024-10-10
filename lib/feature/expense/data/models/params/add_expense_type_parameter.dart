import '../../../../dashboard/data/models/params/merchant_branch_parameter.dart';

class AddExpenseTypeParameter extends MerchantBranchParameter {
  final String name;

  AddExpenseTypeParameter({
    required this.name,
  });

  Map<String, dynamic> toJson() => {
        ...?super.businessToJson(),
        'name': name,
      };
}
