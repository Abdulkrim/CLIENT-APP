import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:merchant_dashboard/core/client/user_session.dart';
import 'package:merchant_dashboard/feature/auth/presentation/pages/login.dart';
import 'package:merchant_dashboard/feature/main_screen/presentation/blocs/main_screen_bloc.dart';
import 'package:merchant_dashboard/feature/main_screen/presentation/blocs/menu_drawer/menu_drawer_cubit.dart';
import 'package:merchant_dashboard/injection.dart';

import '../../routes/app_routes.dart';

class TokenInterceptor extends Interceptor {
  final IUserSession _userSession;

  TokenInterceptor(this._userSession);

  bool _isRefreshing = false;

  final _queuedRequests = <Completer<Response>>[];

  late final _dio = getIt<Dio>();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    super.onError(err, handler);
    if (err.message != null && (err.message!.toLowerCase().contains('xmlhttprequest') || err.response?.statusCode == 401)) {
      if (err.requestOptions.path == 'User/Refresh') {
        _userSession.logout();
        getx.Get.offAll(() => const LoginScreen());
      } else {
        if (!_isRefreshing) {
          _isRefreshing = true;
          final bool isRefreshed = await _userSession.refreshTokenRequest();
          _isRefreshing = false;
          if (isRefreshed) {
            getIt<MainScreenBloc>().add(const InitalEventsCall());
            getx.Get.offAllNamed(AppRoutes.mainRoute);
          }
        }
      }
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    switch (response) {
      case Response<dynamic> response
          when response.statusCode == 401 && response.requestOptions.path == 'User/Refresh':
        for (final completer in _queuedRequests) {
          completer.completeError('Refresh token failed!');
        }
        _queuedRequests.clear();
        _userSession.logout();
        getx.Get.offAll(() => const LoginScreen());

      case Response<dynamic> response
          when response.statusCode == 401 &&
              response.requestOptions.path != 'Subscription/Plans' &&
              response.requestOptions.path != 'Subscription/CommonFeatures' &&
              response.requestOptions.path != 'BranchSubscription/CurrentPlan':
        if (!_isRefreshing) {
          _isRefreshing = true;
          final bool isRefreshed = await _userSession.refreshTokenRequest();
          _isRefreshing = false;
          if (isRefreshed) {
            await _retryQueuedRequests(response, handler);
          }
        } else {
          final completer = Completer<Response>();
          _queuedRequests.add(completer);
          await completer.future;
          await _retryRequest(response, handler);
        }

      case Response<dynamic> response when response.statusCode == 402:
        getIt<MenuDrawerCubit>().forceRedirectToSubscriptionPage();

      default:
        super.onResponse(response, handler);
    }
  }

  _retryQueuedRequests(Response response, ResponseInterceptorHandler handler) async {
    for (final completer in _queuedRequests) {
      if (!completer.isCompleted) completer.complete(response);
    }

    _queuedRequests.clear();
    await _retryRequest(response, handler);
  }

  _retryRequest(Response response, ResponseInterceptorHandler handler) async {
    final retryResponse = await _dio.request(
      response.requestOptions.path,
      data: response.requestOptions.data,
      queryParameters: response.requestOptions.queryParameters,
    );

    handler.next(retryResponse);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (_userSession.hasToken()) {
      var token = _userSession.getUserToken();
      if (token.isNotEmpty) {
        options.headers['authorization'] = 'Bearer $token';
        debugPrint("token found $token");
      }
    } else {
      debugPrint("token not found,ignored. probably a guest.");
    }
    return super.onRequest(options, handler);
  }

  String get fullToken => 'Bearer ${_userSession.getUserToken()}';
}
