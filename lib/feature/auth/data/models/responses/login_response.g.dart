// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      id: json['id'] as String?,
      username: json['username'] as String?,
      role: json['role'] as String?,
      businessId: json['businessId'] as String?,
      branchId: json['branchId'] as String?,
      token: json['token'] as String?,
      refreshToken: json['refreshToken'] as String?,
      message: json['message'] as String?,
      statusCode: (json['statusCode'] as num?)?.toInt(),
      isSucceeded: json['isSucceeded'] as bool?,
      branchName: json['branchName'] as String?,
      businessName: json['businessName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      hasBranch: json['hasBranch'] as bool?,
      email: json['email'] as String?,
      branchCreationDate: json['branchCreationDate'] as String?,
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'role': instance.role,
      'businessId': instance.businessId,
      'branchId': instance.branchId,
      'token': instance.token,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'refreshToken': instance.refreshToken,
      'message': instance.message,
      'statusCode': instance.statusCode,
      'isSucceeded': instance.isSucceeded,
      'branchName': instance.branchName,
      'businessName': instance.businessName,
      'hasBranch': instance.hasBranch,
      'branchCreationDate': instance.branchCreationDate,
    };
