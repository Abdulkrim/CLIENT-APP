import 'package:image_picker/image_picker.dart';

import '../../../../dashboard/data/models/params/merchant_branch_parameter.dart';

class AddSubCategoryParameter extends MerchantBranchParameter {
  final int? mainCategoryId;
  final int? subCategoryId;
  final String categoryEngName;
  final String categoryTrName;
  final String categoryFrName;
  final String categoryArName;
  final bool isActive;
  final XFile? logo;
  final List<String>? visibleApplications;

  AddSubCategoryParameter({
    this.mainCategoryId,
    this.subCategoryId,
    required this.categoryEngName,
    required this.isActive,
    required this.categoryTrName,
    required this.categoryFrName,
    required this.categoryArName,
    this.visibleApplications,
    this.logo,
  });

  Map<String, dynamic> toJson() => {
        ...?super.branchToJson(),
        'CategoryId': mainCategoryId,
        'SubCategoryId': subCategoryId,
        'subCategoryNameEN': categoryEngName,
        'subCategoryNameTR': categoryTrName,
        'subCategoryNameFR': categoryFrName,
        'subCategoryNameAR': categoryArName,
        'IsActive': isActive,
        if (visibleApplications != null && visibleApplications!.isNotEmpty)
          'VisibleApplications': visibleApplications!
      };
}
