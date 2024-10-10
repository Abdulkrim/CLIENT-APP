import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/core/constants/storage_keys.dart';

@injectable
class LocalizationPreferencesHelper {
  final GetStorage _getStorage;


  LocalizationPreferencesHelper(this._getStorage);

  void setLanguage(String lang) async {
   await _getStorage.write(StorageKeys.language,lang);
  }

  String? getLanguage() {
    return _getStorage.read(StorageKeys.language);
  }

  bool alreadySaveLang() {
    return _getStorage.hasData(StorageKeys.language);
  }
}
