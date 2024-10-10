import 'package:flutter_test/flutter_test.dart';
import 'package:merchant_dashboard/feature/auth/data/data_sources/login_local_datasource.dart';
import 'package:merchant_dashboard/feature/dashboard/data/data_source/dashboard_remote_datasource.dart';
import 'package:merchant_dashboard/feature/dashboard/data/repository/dashboard_repository.dart';

import '../../../../helpers/test_mockes.mocks.dart';

void main() {
  late final IDashboardRepository dashboardRepository;
  late final IDashboardRemoteDataSource dashboardRemoteDataSource;
  late final ILoginLocalDataSource loginLocalDataSource;

  setUpAll(() {
    loginLocalDataSource = MockILoginLocalDataSource();
    dashboardRemoteDataSource = MockIDashboardRemoteDataSource();
    dashboardRepository = DashboardRepository(dashboardRemoteDataSource,);
  });
}
