import 'package:equatable/equatable.dart';
import 'package:merchant_dashboard/core/constants/defaults.dart';

class MerchantInfo extends Equatable {
  final String merchantId;
  final String merchantName;
  final String userName;
  final String merchantUserLevel;
  final String? email;
  final String? phoneNumber;

  String get withoutPrefixPhoneNumber => phoneNumber!.replaceFirst('+', '') ;

  bool get isLoggedInUserG => merchantUserLevel == Defaults.userG;

  bool get hasData => merchantId != '0';

  const MerchantInfo(
      {required this.merchantId,
      required this.merchantName,
      required this.userName,
      this.merchantUserLevel = Defaults.userM,
      this.email,
      this.phoneNumber});

  const MerchantInfo.firstItem()
      : merchantId = '0',
        merchantName = 'Select one',
        merchantUserLevel = Defaults.userG,
        userName = '',
        email = '',
        phoneNumber = '';

  @override
  List<Object> get props => [merchantId, merchantName , userName];
}
