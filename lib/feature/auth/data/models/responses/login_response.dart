import 'package:json_annotation/json_annotation.dart';
import 'package:merchant_dashboard/feature/auth/data/models/entities/user_data.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  final String? id;
  final String? username;
  final String? role;
  final String? businessId;
  final String? branchId;
  final String? token;
  final String? phoneNumber;
  final String? email;
  final String? refreshToken;
  final String? message;
  final int? statusCode;
  final bool? isSucceeded;
  final String? branchName;
  final String? businessName;
  final bool? hasBranch;
  final String? branchCreationDate;

  const LoginResponse({
    this.id,
    this.username,
    this.role,
    this.businessId,
    this.branchId,
    this.token,
    this.refreshToken,
    this.message,
    this.statusCode,
    this.isSucceeded,
    this.branchName,
    this.businessName,
    this.phoneNumber,
    this.hasBranch,
    this.email,
    this.branchCreationDate,
  });

  UserData toEntity() => UserData(
        accessToken: token ?? "",
        branchId: branchId ?? "",
        businessId: businessId ?? "",
        userName: username ?? "",
        branchName: branchName ?? "",
        businessName: businessName ?? "",
        refreshToken: refreshToken ?? "",
        phoneNumber: phoneNumber ?? "",
        branchEmail: email ?? "",
        role: role ?? "",
        hasBranch: hasBranch ?? false,
        registeredDate: branchCreationDate ?? '',
      );

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);
}
