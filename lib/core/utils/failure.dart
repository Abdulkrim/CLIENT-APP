class Failure {
  final String errorMessage;

  const Failure([String? errorMessage]) : errorMessage = errorMessage ?? 'Something went wrong';
}

class ServerError extends Failure {
  final String code;

  ServerError(super.errorMessage, this.code);
}

class RequestError extends Failure {
  RequestError(super.errorMessage);
}

class ServerWithResponse extends Failure {
  Map<String, dynamic> response;
  ServerWithResponse(super.errorMessage, this.response);
}
class CancelledError extends Failure {
  CancelledError();
}


