// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountDetailsResponse _$AccountDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    AccountDetailsResponse(
      merchantId: json['merchantId'] as String?,
      businessName: json['businessName'] as String?,
      businessAddress: json['businessAddress'] as String?,
      country: json['country'] as String?,
      contactName: json['contactName'] as String?,
      emailAddress: json['emailAddress'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
    );

Map<String, dynamic> _$AccountDetailsResponseToJson(
        AccountDetailsResponse instance) =>
    <String, dynamic>{
      'merchantId': instance.merchantId,
      'businessName': instance.businessName,
      'businessAddress': instance.businessAddress,
      'country': instance.country,
      'contactName': instance.contactName,
      'emailAddress': instance.emailAddress,
      'phoneNumber': instance.phoneNumber,
    };
