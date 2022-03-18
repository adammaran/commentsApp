import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class ApiClient {
  static final ApiClient _api = ApiClient._internal();

  factory ApiClient() {
    return _api;
  }

  ApiClient._internal();

  Dio get dio {
    Dio dioClient = Dio();
    dioClient.interceptors
      ..clear()
      ..add(InterceptorsWrapper(onRequest: (options, handler) {
        debugPrint(
            'Request: ${options.baseUrl + options.path} ${options.queryParameters}');
        debugPrint('Headers: ${options.headers.toString()}');
        return handler.next(options);
      }, onResponse: (options, handler) {
        debugPrint(options.statusCode.toString());
        return handler.next(options);
      }, onError: (DioError error, handler) async {
        if (error.response != null) {
          debugPrint('############ ERRORRR: $error');
          return handler.next(error);
        }
      }));

    return dioClient;
  }
}
