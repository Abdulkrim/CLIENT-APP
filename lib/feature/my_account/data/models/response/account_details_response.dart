import 'package:json_annotation/json_annotation.dart';
import 'package:merchant_dashboard/feature/my_account/data/models/entity/account_details.dart';

part 'account_details_response.g.dart';

@JsonSerializable()
class AccountDetailsResponse {
  final String? merchantId;
  final String? businessName;
  final String? businessAddress;
  final String? country;
  final String? contactName;
  final String? emailAddress;
  final String? phoneNumber;

  AccountDetailsResponse({
    this.merchantId,
    this.businessName,
    this.businessAddress,
    this.country,
    this.contactName,
    this.emailAddress,
    this.phoneNumber,
  });

  factory AccountDetailsResponse.fromJson(Map<String, dynamic> json) => _$AccountDetailsResponseFromJson(json);

  AccountDetails toEntity() => AccountDetails(
      merchantId: merchantId ?? '',
      businessName: businessName ?? '',
      businessAddress: businessAddress ?? '',
      country: country ?? '',
      contactName: contactName ?? '',
      emailAddress: emailAddress ?? '',
      phoneNumber: phoneNumber ?? '');
}
