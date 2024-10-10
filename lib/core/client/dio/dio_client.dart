import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

abstract class IDioClient {
  Future<Response<dynamic>> get({required String path, Map<String, dynamic>? queryParameters, CancelToken? cancelToken});
}

@LazySingleton(as: IDioClient)
class DioClient implements IDioClient {
  final Dio _dio;

  DioClient(this._dio);

  @override
  Future<Response> get({required String path, Map<String, dynamic>? queryParameters, CancelToken? cancelToken}) =>
      _dio.get(path, queryParameters: queryParameters, cancelToken: cancelToken);
}
