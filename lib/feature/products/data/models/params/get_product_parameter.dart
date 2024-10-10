import 'package:merchant_dashboard/feature/dashboard/data/models/params/merchant_branch_parameter.dart';

class GetProductByBarcodeParameter extends MerchantBranchParameter {
  final String? searchText;

  GetProductByBarcodeParameter({this.searchText});

  Map<String, dynamic> byBarcodeToJson() => {
        'searchKey': searchText,
        ...?super.branchToJson(),
      };
}
