import 'package:json_annotation/json_annotation.dart';
import 'package:merchant_dashboard/feature/merchant_info/data/models/entity/merchant_information.dart';

part 'merchant_information_response.g.dart';

@JsonSerializable()
class MerchantInformationResponse {
  String? name;
  String? firstPhoneNumber;
  String? email;
  Address? address;
  SocialMedia? socialMedia;
  String? branchDescription;
  String? logoLink;
  String? defaultLogoLink;
  String? printingLogoLink;
  String? footerLogoLink;
  String? domainAddress;

  MerchantInformationResponse(
      {this.name,
      this.firstPhoneNumber,
      this.email,
      this.address,
      this.socialMedia,
      this.branchDescription,
      this.logoLink,
      this.defaultLogoLink,
      this.printingLogoLink,
      this.domainAddress,
      this.footerLogoLink});

  factory MerchantInformationResponse.fromJson(Map<String, dynamic> json) =>
      _$MerchantInformationResponseFromJson(json);

  MerchantInformation toEntity() => MerchantInformation(
      name: name ?? '',
      firstPhoneNumber: firstPhoneNumber ?? '',
      domainAddress: domainAddress ?? '',
      email: email ?? '',
      location: address?.location ?? '',
      branchAddress: address?.branchAddress ?? '',
      countryName: address?.countryName ?? '',
      cityName: address?.cityName ?? '',
      facebookLink: socialMedia?.facebookLink ?? '',
      instagramLink: socialMedia?.instagramLink ?? '',
      whatsapp: socialMedia?.whatsapp ?? '',
      twitter: socialMedia?.twitter ?? '',
      branchDescription: branchDescription ?? '',
      logoLink: logoLink ?? '',
      defaultLogoLink: defaultLogoLink ?? '',
      printingLogoLink: printingLogoLink ?? '',
      footerLogoLink: footerLogoLink ?? '');
}

class Address {
  int? id;
  String? location;
  String? branchAddress;
  String? countryName;
  String? cityName;

  Address({this.id, this.location, this.branchAddress, this.countryName, this.cityName});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    location = json['location'];
    branchAddress = json['branchAddress'];
    countryName = json['countryName'];
    cityName = json['cityName'];
  }
  Map<String, dynamic> toJson() => {};
}

class SocialMedia {
  String? facebookLink;
  String? instagramLink;
  String? whatsapp;
  String? twitter;

  SocialMedia({this.facebookLink, this.instagramLink, this.whatsapp});

  SocialMedia.fromJson(Map<String, dynamic> json) {
    facebookLink = json['facebookLink'];
    instagramLink = json['instagramLink'];
    whatsapp = json['whatsapp'];
    twitter = json['twitter'];
  }
  Map<String, dynamic> toJson() => {};
}
