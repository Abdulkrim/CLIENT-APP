import 'package:merchant_dashboard/core/constants/defaults.dart';

class UserData {
  final String accessToken;
  final String refreshToken;
  final String userName;
  final String role;
  final String _businessId;
  final String _branchId;

  final String _businessName;
  final String branchName;
  final String phoneNumber;
  final String branchEmail;
  final String registeredDate;

  String get merchantId => switch (role) {
        Defaults.userG => _businessId,
        Defaults.userM => _branchId,
        _ => '--',
      };

  String get merchantName => switch (role) {
        Defaults.userG => _businessName,
        Defaults.userM => branchName,
        _ => '--',
      };
  String get branchID => _branchId;
  String get businessId => _businessId;
  bool get isBranchOrBusiness => role == Defaults.userG || role == Defaults.userM;

  bool get isAdmin => role == Defaults.userA;


  final bool hasBranch;

  UserData({
    required this.accessToken,
    required this.refreshToken,
    required this.userName,
    required String businessId,
    required String branchId,
    required String businessName,
    required this.branchName,
    required this.branchEmail,
    required this.phoneNumber,
    required this.role,
    required this.hasBranch,
    required this.registeredDate,
  })  : _businessName = businessName,
        _businessId = businessId,
        _branchId = branchId;
}
