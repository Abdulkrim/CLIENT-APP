import 'package:dio/dio.dart';
import 'package:merchant_dashboard/core/utils/failure.dart';

class BaseException implements Exception {
  final String? errorMessage;

  const BaseException({
    this.errorMessage = "Unknown error",
  });
}

class ServerException extends BaseException {
  final String code;

  const ServerException([String? msg = '--', this.code = '--']) : super(errorMessage: msg);
}

class RegisterException extends DioException {
  RegisterException({required super.requestOptions});
}

class RequestException extends BaseException {
  const RequestException(String msg) : super(errorMessage: msg);
}

class RequestCancelled extends BaseException {
  const RequestCancelled() : super();
}

extension FailurConversion on BaseException {
  Failure toFailure() => switch (this) {
        (ServerException ext) => ServerError(ext.errorMessage, ext.code),
        (RegisterException ext) => ServerError('', '-'),
        (RequestException ext) => RequestError(ext.errorMessage),
        (RequestCancelled ext) => CancelledError(),
        _ => ServerError('', ''),
      };
}
