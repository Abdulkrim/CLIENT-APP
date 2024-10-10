import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../constants/defaults.dart';

mixin RequestCancelToken {
  final List<CancelToken> _cancelTokens = [];

  Future<void> cancelAllRequests() async {
    for (var cancelToken in _cancelTokens) {
      if (!cancelToken.isCancelled) {

        cancelToken.cancel("${cancelToken.requestOptions?.path} Cancelled.");
      }
    }
    _cancelTokens.clear();
  }

  CancelToken getCancelToken(String apiName) {
    CancelToken cancelToken = CancelToken();
    _cancelTokens.add(cancelToken);
    return cancelToken;
  }

  CancelToken cancelRequest(CancelToken cancelToken) {
    try {
      cancelToken.cancel(Defaults.canceledRequest);

      debugPrint("CancelToken Cancelled DONE :) ${cancelToken.requestOptions?.path}");
    } catch (e) {
      debugPrint("CancelToken We have an error in cancelling: $e");
    }

    return CancelToken();
  }


}
