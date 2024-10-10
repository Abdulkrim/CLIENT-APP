import 'package:image_picker/image_picker.dart';
import 'package:merchant_dashboard/feature/dashboard/data/models/params/merchant_branch_parameter.dart';

class AddMainCategoryParameter extends MerchantBranchParameter {
  final String categoryEngName;
  final String categoryTrName;
  final String categoryFrName;
  final String categoryArName;
  final bool isActive;
  final List<String>? visibleApplications;
  final XFile? logo;

  final int? categoryId;

  AddMainCategoryParameter({
    required this.categoryEngName,
    required this.isActive,
    required this.categoryTrName,
    required this.categoryFrName,
    required this.categoryArName,
    this.logo,
    this.categoryId,
    this.visibleApplications,
  });

  Map<String, dynamic> toJson() => {
        ...?super.branchToJson(),
        'CategoryNameEN': categoryEngName,
        'CategoryNameAR': categoryArName,
        'CategoryNameFR': categoryFrName,
        'CategoryNameTR': categoryTrName,
        'CategoryId': categoryId,
        'IsActive': isActive,
        if (visibleApplications != null && visibleApplications!.isNotEmpty)
          'VisibleApplications': visibleApplications!
      };
}
