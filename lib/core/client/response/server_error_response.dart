class ServerErrorResponse {
  final String? _dioErrorMessage;
  final String? _serverErrorMessage;
  final String? _requestErrorMessage;
  final List<dynamic>? _errorMessages;
  final Map<String, dynamic>? _errorMaps;

  String get serverMessage =>
      _serverErrorMessage ??
      _errorMessages?.join(',') ??
      _errorMaps?.values.join(',') ??
      _requestErrorMessage ??
      _dioErrorMessage ??
      'Somthing went wrong';

  ServerErrorResponse(
      {String? dioErrorMessage,
      String? serverErrorMessage,
      String? requestErrorMessage,
      List<dynamic>? errorMessages,
      Map<String, dynamic>? errorMaps})
      : _dioErrorMessage = dioErrorMessage,
        _serverErrorMessage = serverErrorMessage,
        _requestErrorMessage = requestErrorMessage,
        _errorMaps = errorMaps,
        _errorMessages = errorMessages;

  factory ServerErrorResponse.fromJson(dynamic json, String dioErrorMessage) {
    List<dynamic>? errList;
    Map<String, dynamic>? errMap;

    if (json is Map<String, dynamic>?) {
      if (json?['errors'] is List<dynamic>?) {
        errList = json?['errors'];
      } else if (json?['errors'] is Map<String, dynamic>?) {
        errMap = json?['errors'];
      }

      return ServerErrorResponse(
        dioErrorMessage: dioErrorMessage,
        serverErrorMessage: json?['Message'],
        requestErrorMessage: json?['message'],
        errorMessages: errList,
        errorMaps: errMap,
      );
    } else {
      return ServerErrorResponse(
        serverErrorMessage: 'unknown server error',
      );
    }
  }
}
