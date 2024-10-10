import 'package:merchant_dashboard/core/utils/configuration.dart';
import 'package:merchant_dashboard/feature/dashboard/data/models/params/merchant_branch_parameter.dart';
import 'package:merchant_dashboard/injection.dart';

class AddBranchParameter extends MerchantBranchParameter {
  final String name;
  final String phoneNumber;
  final String email;
  final String domainAddress;
  final String branchAddress;
  final int businessTypeId;
  final int? cityId;
  final int countryId;
  final String cityName;

  AddBranchParameter({
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.domainAddress,
    required this.branchAddress,
    required this.businessTypeId,
    required this.cityId,
    required this.cityName,
    required this.countryId,
  });

  Map<String, dynamic> toJson() => {
        "businessId": super.businessId,
        "name": name,
        "firstPhoneNumber": phoneNumber,
        "email": email,
        "businessTypeId": businessTypeId,
        "domainAddress": '$domainAddress.${getIt<Configuration>().branchUrl}',
        "address": {
          "location": "string",
          "branchAddress": branchAddress,
          "cityId": cityId == -1 ? null : cityId,
          "cityName": cityName,
          "countryId": countryId,
        }
      };
}
