class Branch {
  final String branchId;
  final String name;
  final String firstPhoneNumber;
  final String email;
  final int businessTypeId;
  final String businessTypeName;
  final String domainAddress;
  final String branchAddress;
  final int countryId;
  final String countryName;
  final int cityId;
  final String cityName;

  Branch(
      {required this.branchId,
      required this.name,
      required this.firstPhoneNumber,
      required this.email,
      required this.businessTypeId,
      required this.businessTypeName,
      required this.domainAddress,
      required this.branchAddress,
      required this.countryId,
      required this.countryName,
      required this.cityId,
      required this.cityName});
}
