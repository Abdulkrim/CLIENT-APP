import 'package:equatable/equatable.dart';

class MerchantInformation extends Equatable {
  final String name;
  final String _firstPhoneNumber;
  String get firstPhoneNumber => _firstPhoneNumber.replaceFirst('+', '');

  final String location;
  final String branchAddress;
  final String countryName;
  final String cityName;
  final String facebookLink;
  final String instagramLink;
  final String email;
  final String whatsapp;
  final String twitter;
  final String branchDescription;
  final String logoLink;
  final String defaultLogoLink;
  final String printingLogoLink;
  final String footerLogoLink;
  final String domainAddress;

  const MerchantInformation({
    required this.name,
    required this.domainAddress,
    required String firstPhoneNumber,
    required this.email,
    required this.location,
    required this.branchAddress,
    required this.countryName,
    required this.cityName,
    required this.facebookLink,
    required this.instagramLink,
    required this.whatsapp,
    required this.twitter,
    required this.branchDescription,
    required this.logoLink,
    required this.defaultLogoLink,
    required this.printingLogoLink,
    required this.footerLogoLink,
  }): _firstPhoneNumber  = firstPhoneNumber;

  @override
  List<Object> get props => [
        name,
        domainAddress,
        firstPhoneNumber,
        email,
        location,
        branchAddress,
        countryName,
        cityName,
        facebookLink,
        instagramLink,
        whatsapp,
        twitter,
        branchDescription,
        logoLink,
        defaultLogoLink,
        printingLogoLink,
        footerLogoLink,
      ];
}
