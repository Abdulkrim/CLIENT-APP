import 'package:merchant_dashboard/core/utils/app_environment.dart';
import 'package:injectable/injectable.dart';

abstract class Configuration {
  String get name;

  String get getBaseUrl;

  String get branchUrl;

  bool get isProduction;
}

@LazySingleton(as: Configuration, env: [AppEnvironment.dev])
class DevConfiguration implements Configuration {
  @override
  String get getBaseUrl => 'https://dev-api-client.catalogak.net/api/v5/';

  @override
  String get name => 'development';

  @override
  String get branchUrl => 'catalogak.info';

  @override
  bool get isProduction => false;
}

@LazySingleton(as: Configuration, env: [AppEnvironment.staging])
class StagingConfiguration implements Configuration {
  @override
  String get getBaseUrl => 'https://stg-api-client.catalogak.net/api/v5/';

  @override
  String get name => 'staging';

  @override
  String get branchUrl => 'catalogak.info';

  @override
  bool get isProduction => false;
}

@LazySingleton(as: Configuration, env: [AppEnvironment.prod])
class ProductionConfiguration implements Configuration {
  @override
  String get getBaseUrl => 'https://merchant.catalogak.net/api/v5/';

  @override
  String get name => 'production';

  @override
  String get branchUrl => 'catalogak.com';

  @override
  bool get isProduction => true;
}
