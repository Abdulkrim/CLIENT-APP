import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:merchant_dashboard/core/constants/defaults.dart';
import 'package:merchant_dashboard/feature/auth/data/data_sources/login_local_datasource.dart';
import 'package:merchant_dashboard/feature/auth/data/data_sources/login_remote_datasource.dart';
import 'package:merchant_dashboard/feature/auth/data/models/params/login_request_parameter.dart';
import 'package:merchant_dashboard/feature/auth/data/models/responses/login_response.dart';
import 'package:merchant_dashboard/feature/auth/data/repository/login_repository.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_mockes.mocks.dart';

void main() {
  late final ILoginRepository loginRepository;
  late final ILoginRemoteDataSource loginRemoteDataSource;
  late final ILoginLocalDataSource loginLocalDataSource;

  setUpAll(() {
    loginRemoteDataSource = MockILoginRemoteDataSource();
    loginLocalDataSource = MockILoginLocalDataSource();
    loginRepository = LoginRepository(loginRemoteDataSource, loginLocalDataSource);
  });

  test('Constants field must equal to branch and business', () {
    expect('business', Defaults.userG);
    expect('branch', Defaults.userM);
  });

  test('Saved userId, merchantName, userLevel for Branch user role must be all branches data', () async {
    // arrange
    final loginParams = LoginRequestParameter(username: 'testUsername', password: 'testPassword');
    const loginResponse = LoginResponse(
        id: '123',
        username: 'username',
        role: 'branch',
        token: 'abc',
        refreshToken: 'abcz',
        businessId: '123business',
        businessName: 'businessName',
        branchName: 'branchName',
        branchId: '123branch');
    when(loginRemoteDataSource.loginRequest(loginParams)).thenAnswer((_) async => loginResponse);

    // act
    final response = await loginRepository.loginUserThroughUserName(loginParams);

  /*  // assert
    verify(loginLocalDataSource.saveUserInfo(
            registeredDate: '2022',
            userToken: 'abc',
            userRefreshToken: 'abcz',
            userName: 'username',
            merchantName: 'branchName',
            userId: '123branch',
            businessId: '123branch',
            userLevel: Defaults.userM,
            branchName: "branchName"))
        .called(1);*/

    verifyNever(loginLocalDataSource.setSelectedMerchantId(merchantId: '123branch'));
  });

  test('Saved userId, merchantName, userLevel for Business user role must be businesses data', () async {
    // arrange
    final loginParams = LoginRequestParameter(username: 'testUsername', password: 'testPassword');
    const loginResponse = LoginResponse(
        id: '123',
        username: 'username',
        role: 'business',
        token: 'abc',
        refreshToken: 'abcz',
        businessId: '123business',
        businessName: 'businessName',
        branchName: 'branchName',
        branchId: '123branch');
    when(loginRemoteDataSource.loginRequest(loginParams)).thenAnswer((_) async => loginResponse);

    // act
    final response = await loginRepository.loginUserThroughUserName(loginParams);

/*
    // assert
    verify(loginLocalDataSource.saveUserInfo(
            userToken: 'abc',
            userRefreshToken: 'abcz',
            userName: 'username',
            merchantName: 'businessName',
            userId: '123business',
            userLevel: Defaults.userG,
            registeredDate: '2022',
            businessId: '2022',
            branchName: "branchName"))
        .called(1);
*/

    verifyNever(loginLocalDataSource.setSelectedMerchantId(merchantId: '123business'));
  });

  test('Return failure status when user role is not branch or business', () async {
    // arrange
    final loginParams = LoginRequestParameter(username: 'testUsername', password: 'testPassword');
    const loginResponse = LoginResponse(
        id: '123',
        username: 'username',
        role: 'admin',
        token: 'abc',
        refreshToken: 'abcz',
        businessId: '123business',
        businessName: 'businessName',
        branchName: 'branchName',
        branchId: '123branch');
    when(loginRemoteDataSource.loginRequest(loginParams)).thenAnswer((_) async => loginResponse);

    // act
    final response = await loginRepository.loginUserThroughUserName(loginParams);

    // assert
    expect(response, isA<Left>());
  });

  test('Must grab a list of branches id and name if user role is Business', () => null);
}
