import '../entity/branch_general_info.dart';

class BranchGeneralInfoResponse {
  String? currency;
  String? businessType;
  int? businessTypeId;
  String? branchId;
  String? domainAddress;

  BranchGeneralInfoResponse.fromJson(Map<String, dynamic> json)
      : currency = json['currency'],
        businessType = json['businessType'],
        businessTypeId = json['businessTypeId'],
        domainAddress = json['domainAddress'],
        branchId = json['branchId'];

  BranchGeneralInfo toEntity() => BranchGeneralInfo(
      currency: currency ?? '',   domainAddress: domainAddress ?? '', businessType: businessType ?? '', businessTypeId: businessTypeId ?? 0, branchId: branchId ?? '');
}


