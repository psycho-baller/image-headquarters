import 'dart:io';

import 'package:dio/dio.dart';
import '../http_client.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    //TODO: Put the paths you want the interceptor to ignore
    if (!options.path.contains('/login')) {
      var token = HttpClient.google_photos_api;
      options.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
    }
    handler.next(options);
  }
}
