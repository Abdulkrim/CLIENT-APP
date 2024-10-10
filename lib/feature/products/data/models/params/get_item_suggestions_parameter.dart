import 'package:merchant_dashboard/feature/dashboard/data/models/params/merchant_branch_parameter.dart';

class GetItemSuggestionsParameter extends MerchantBranchParameter {
  final String name;

  GetItemSuggestionsParameter({required this.name});

  Map<String, dynamic> toJson() => {...?super.branchToJson(), 'name': name};
}
