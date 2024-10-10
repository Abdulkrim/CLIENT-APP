// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_information_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantInformationResponse _$MerchantInformationResponseFromJson(
        Map<String, dynamic> json) =>
    MerchantInformationResponse(
      name: json['name'] as String?,
      firstPhoneNumber: json['firstPhoneNumber'] as String?,
      email: json['email'] as String?,
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      socialMedia: json['socialMedia'] == null
          ? null
          : SocialMedia.fromJson(json['socialMedia'] as Map<String, dynamic>),
      branchDescription: json['branchDescription'] as String?,
      logoLink: json['logoLink'] as String?,
      defaultLogoLink: json['defaultLogoLink'] as String?,
      printingLogoLink: json['printingLogoLink'] as String?,
      domainAddress: json['domainAddress'] as String?,
      footerLogoLink: json['footerLogoLink'] as String?,
    );

Map<String, dynamic> _$MerchantInformationResponseToJson(
        MerchantInformationResponse instance) =>
    <String, dynamic>{
      'name': instance.name,
      'firstPhoneNumber': instance.firstPhoneNumber,
      'email': instance.email,
      'address': instance.address,
      'socialMedia': instance.socialMedia,
      'branchDescription': instance.branchDescription,
      'logoLink': instance.logoLink,
      'defaultLogoLink': instance.defaultLogoLink,
      'printingLogoLink': instance.printingLogoLink,
      'footerLogoLink': instance.footerLogoLink,
      'domainAddress': instance.domainAddress,
    };
