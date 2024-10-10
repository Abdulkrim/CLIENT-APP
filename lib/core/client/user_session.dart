import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/core/constants/storage_keys.dart';
import 'package:merchant_dashboard/feature/auth/data/data_sources/login_local_datasource.dart';
import 'package:merchant_dashboard/injection.dart';



abstract class IUserSession {
  bool hasToken();

  String getUserToken();

  Future<bool> refreshTokenRequest();

  void logout();
}

@LazySingleton(as: IUserSession, order: -1)
class UserSession extends IUserSession {
  final GetStorage _getStorage;

  final ILoginLocalDataSource _localDataSource;

  UserSession(this._getStorage, this._localDataSource);

  @override
  String getUserToken() => _getStorage.read(StorageKeys.userToken);

  @override
  bool hasToken() => _getStorage.hasData(StorageKeys.userToken);

  @override
  void logout() => _localDataSource.logoutUser();

  String _getUserRefreshToken() => _getStorage.read(StorageKeys.userRefreshToken) ?? '';

  @override
  Future<bool> refreshTokenRequest() async {
    try {
      final refreshToken = _getUserRefreshToken();
      final Response response = await getIt<Dio>().post("User/Refresh", data: {'RefreshToken': refreshToken});

      if (response.data case {'token': String token, 'refreshToken': String refToken}) {
        _localDataSource.updateUserTokens(token: token, refreshToken: refToken);

        return true;
      }

      return false;
    } on DioException catch (_) {
      return false;
    }
  }
}
