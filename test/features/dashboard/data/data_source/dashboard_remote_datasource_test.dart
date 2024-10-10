import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:merchant_dashboard/feature/auth/data/data_sources/login_local_datasource.dart';
import 'package:merchant_dashboard/feature/dashboard/data/data_source/dashboard_remote_datasource.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_mockes.mocks.dart';

void main(){

  late final IDashboardRemoteDataSource dashboardRemoteDataSource;
  late final Dio dioClient;
  late final ILoginLocalDataSource loginLocalDataSource;

  setUpAll(() {
    dioClient = MockDio();
    loginLocalDataSource = MockILoginLocalDataSource();
    dashboardRemoteDataSource = DashboardRemoteDataSource(dioClient);
  });
  
  test('Send branchId if user selected a branch', () async{
    // arrange
    when(loginLocalDataSource.getSelectedMerchantId()).thenReturn('123');
    // when(dioClient.get('path',queryParameters: DashboardDataParameter().toJson())).thenAnswer((_) async {})

    // act
    final response = await dashboardRemoteDataSource.getSalesPerToday();

    // assert


  });
  
  test('Do not send branchId if user did not select a branch', () {});
  
}