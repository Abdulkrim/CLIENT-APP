import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/core/constants/storage_keys.dart';

import '../../../../core/constants/defaults.dart';

abstract class ILoginLocalDataSource {
  void saveUserInfo(
      {required String userToken,
      required String userRefreshToken,
      required String userName,
      required String merchantName,
      required String userId,
      required String branchName,
      required String userLevel,
      required String businessId,
      required String phoneNumber,
      required String branchEmail,
      required bool hasBranch,
      required String registeredDate});


  void updateUserTokens({required String token, required String refreshToken});

  void logoutUser();

  String getSelectedMerchantId();

  String getUserLevel();

  String getUserId();

  String getBusinessId();

  String getUserMerchantName();

  String getLoggedInUserPhoneNumber();

  String getUserName();

  String getLoggedInUserEmail();

  String getUserRegisteredDate();

  void setSelectedMerchantId({required String merchantId});

  bool isLoggedInUserBusiness();

  String getBranchName();

  bool hasBranch();

  void saveHasBranch(bool hasBranch);

  ({String userId, String userName, String merchantName, String userLevel, String businessId, String branchName})
      getLoggedInUserInfo();
}

@LazySingleton(as: ILoginLocalDataSource)
class LocalDataSource extends ILoginLocalDataSource {
  final GetStorage _getStorage;

  LocalDataSource(this._getStorage);

  @override
  ({String userId, String userName, String merchantName, String userLevel, String businessId, String branchName})
      getLoggedInUserInfo() {
    return (
      userId: _getStorage.read(StorageKeys.userId) ?? '-',
      userName: _getStorage.read(StorageKeys.userName) ?? '-',
      merchantName: _getStorage.read(StorageKeys.merchantName) ?? '-',
      userLevel: _getStorage.read(StorageKeys.userLevel) ?? '-',
      businessId: _getStorage.read(StorageKeys.businessId) ?? '-',
      branchName: _getStorage.read(StorageKeys.branchName) ?? '-'
    );
  }

  @override
  void saveUserInfo(
      {required String userToken,
      required String userRefreshToken,
      required String userName,
      required String merchantName,
      required String userId,
      required String branchName,
      required String userLevel,
      required String businessId,
      required String phoneNumber,
      required String branchEmail,
      required bool hasBranch,
      required String registeredDate}) {
    _getStorage.write(StorageKeys.userId, userId);
    _getStorage.write(StorageKeys.userName, userName);
    _getStorage.write(StorageKeys.merchantName, merchantName);
    _getStorage.write(StorageKeys.userToken, userToken);
    _getStorage.write(StorageKeys.userRefreshToken, userRefreshToken);
    _getStorage.write(StorageKeys.userLevel, userLevel);
    _getStorage.write(StorageKeys.branchName, branchName);
    _getStorage.write(StorageKeys.registeredDate, registeredDate);
    _getStorage.write(StorageKeys.businessId, businessId);
    _getStorage.write(StorageKeys.phoneNumber, phoneNumber);
    _getStorage.write(StorageKeys.branchEmail, branchEmail);
    _getStorage.write(StorageKeys.hasBranch, hasBranch);
  }

  @override
  void updateUserTokens({required String token, required String refreshToken}) {
    _getStorage.write(StorageKeys.userToken, token);
    _getStorage.write(StorageKeys.userRefreshToken, refreshToken);
  }

  @override
  void logoutUser() {
    _getStorage.erase();
  }

  /// Return an empty value or an id which is the selected branch id from [MainScreenBloc]
  @override
  String getSelectedMerchantId() {
    String mId = _getStorage.read(StorageKeys.merchantId) ?? '';
    return (mId.isEmpty || mId == '0') ? '' : mId;
  }

  /// Fulfil with branch id which is selected from [MainScreenBloc]
  @override
  void setSelectedMerchantId({required String merchantId}) {
    _getStorage.write(StorageKeys.merchantId, merchantId);
  }

  @override
  bool isLoggedInUserBusiness() => getUserLevel() == Defaults.userG;

  @override
  bool hasBranch() =>
      (_getStorage.read(StorageKeys.hasBranch) ?? false) || (_getStorage.read(StorageKeys.haveBranchAddress) ?? false);

  /// Logged in [branchName] field of loggedIn user
  @override
  String getBranchName() => _getStorage.read(StorageKeys.branchName) ?? '';

  /// Logged in user level
  @override
  String getUserLevel() => _getStorage.read(StorageKeys.userLevel) ?? '';

  /// Logged in user id which saved by [userId] key
  @override
  String getUserId() => _getStorage.read(StorageKeys.userId) ?? '';

  /// Logged in user businessId regardless of whether the role is the branch or business
  @override
  String getBusinessId() => _getStorage.read(StorageKeys.businessId) ?? '';

  @override
  String getUserMerchantName() => _getStorage.read(StorageKeys.merchantName) ?? '';

  @override
  String getUserRegisteredDate() => _getStorage.read(StorageKeys.registeredDate) ?? '';

  @override
  String getUserName() => _getStorage.read(StorageKeys.userName) ?? '';


  @override
  String getLoggedInUserEmail() => _getStorage.read(StorageKeys.branchEmail) ?? '';

  @override
  String getLoggedInUserPhoneNumber() => _getStorage.read(StorageKeys.phoneNumber) ?? '';

  @override
  void saveHasBranch(bool hasBranch) {
    _getStorage.write(StorageKeys.hasBranch, hasBranch);
  }
}
