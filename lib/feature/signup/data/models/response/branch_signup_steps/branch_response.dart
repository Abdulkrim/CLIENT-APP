import 'package:merchant_dashboard/feature/signup/data/models/entity/branch.dart';

class BranchResponse {
  String? branchId;
  String? name;
  String? firstPhoneNumber;
  String? email;
  int? businessTypeId;
  String? businessTypeName;
  String? domainAddress;
  String? branchAddress;
  int? countryId;
  String? countryName;
  int? cityId;
  String? cityName;

  BranchResponse({this.branchId,
    this.name,
    this.firstPhoneNumber,
    this.email,
    this.businessTypeId,
    this.businessTypeName,
    this.domainAddress,
    this.branchAddress,
    this.countryId,
    this.countryName,
    this.cityId,
    this.cityName});

  BranchResponse.fromJson(Map<String, dynamic> json) {
    branchId = json['branchId'];
    name = json['name'];
    firstPhoneNumber = json['firstPhoneNumber'];
    email = json['email'];
    businessTypeId = json['businessTypeId'];
    businessTypeName = json['businessTypeName'];
    domainAddress = json['domainAddress'];
    branchAddress = json['branchAddress'];
    countryId = json['countryId'];
    countryName = json['countryName'];
    cityId = json['cityId'];
    cityName = json['cityName'];
  }

  Map<String , dynamic> toJson() =>{};

  Branch toEntity() =>
      Branch(branchId: branchId ?? '',
          name: name ?? '',
          firstPhoneNumber: firstPhoneNumber ?? '',
          email: email ?? '',
          businessTypeId: businessTypeId ?? -1,
          businessTypeName: businessTypeName ?? '',
          domainAddress: domainAddress ?? '',
          branchAddress: branchAddress ?? '',
          countryId: countryId ?? -1,
          countryName: countryName ?? '',
          cityId: cityId ?? -1,
          cityName: cityName ?? '');
}