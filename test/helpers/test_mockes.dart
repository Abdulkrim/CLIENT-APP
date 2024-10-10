import 'package:dio/dio.dart';
import 'package:merchant_dashboard/feature/auth/data/data_sources/login_local_datasource.dart';
import 'package:merchant_dashboard/feature/auth/data/data_sources/login_remote_datasource.dart';
import 'package:merchant_dashboard/feature/dashboard/data/data_source/dashboard_remote_datasource.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([
  MockSpec<ILoginRemoteDataSource>(),
  MockSpec<ILoginLocalDataSource>(),
  MockSpec<IDashboardRemoteDataSource>(),
  MockSpec<Dio>()
])
void main() {}
