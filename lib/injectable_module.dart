import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:merchant_dashboard/core/client/token_interceptor.dart';
import 'package:merchant_dashboard/core/client/user_session.dart';
import 'package:merchant_dashboard/core/utils/configuration.dart';
import 'package:merchant_dashboard/injection.dart';

@module
abstract class InjectableModule {
  @LazySingleton(order: -2)
  GetStorage get getStorage => GetStorage();

  @lazySingleton
  CancelToken compute() => CancelToken();

  @lazySingleton
  Dio get dioInstance {
    final dio = Dio(
      BaseOptions(
          headers: {
            'Access-Control-Allow-Origin': "*",
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        /*  validateStatus: (statusCode) {
            if (statusCode != null) {
              if ((200 <= statusCode && statusCode < 300) || statusCode == 401 || statusCode == 402) {
                return true;
              } else {
                return false;
              }
            } else {
              return false;
            }
          }*/),
    );
    dio.options.baseUrl = getIt<Configuration>().getBaseUrl;
    dio.interceptors.add(
      LogInterceptor(
        responseBody: true,
        requestBody: true,
        request: true,
        requestHeader: true,
        error: true,
        responseHeader: true,
        logPrint: (obj) {
          debugPrint(obj.toString());
        },
      ),
    );
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) async {
          request.sendTimeout = const Duration(milliseconds: 600000);
          request.connectTimeout = const Duration(milliseconds: 600000);
          request.receiveTimeout = const Duration(milliseconds: 600000);
          return handler.next(request);
        },
      ),
    );
    dio.interceptors.add(TokenInterceptor(getIt<IUserSession>()));
    return dio;
  }

  @lazySingleton
  Logger get logger => Logger();

  @lazySingleton
  Random get random => Random();
}
