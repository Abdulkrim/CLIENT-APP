import 'package:merchant_dashboard/feature/dashboard/data/models/params/merchant_branch_parameter.dart';

class EditMerchantInformationParameter extends MerchantBranchParameter {
  final String address;
  final String facebook;
  final String instagram;
  final String twitter;
  final String firstPhoneNumber;
  final String email;

  EditMerchantInformationParameter({
    required this.address,
    required this.facebook,
    required this.instagram,
    required this.twitter,
    required this.firstPhoneNumber,
    required this.email,
  });

  Map<String, dynamic> toJson() => {
        ...?super.branchToJson(),
        'branchAddress': address,
        'facebook': facebook,
        'instagram': instagram,
        'twitter': twitter,
        'firstPhoneNumber': firstPhoneNumber,
        'email': email,
      };
}
