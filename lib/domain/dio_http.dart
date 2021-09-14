import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

final dio = Dio(BaseOptions(
  baseUrl: 'https://test-backend-flutter.surfstudio.ru',
  connectTimeout: 5000,
  receiveTimeout: 5000,
  sendTimeout: 5000,
  responseType: ResponseType.json,
));

void initInterceptor() {
  dio.interceptors.add(InterceptorsWrapper(
    onError: (e, handler) {
      debugPrint('Request error: ${e.message}');
      return handler.next(e);
    },
    onRequest: (options, handler) {
      debugPrint('Request data options: ${options.data}');
      return handler.next(options);
    },
    onResponse: (response, handler) {
      debugPrint('Response data: ${response.data}');
      return handler.next(response);
    },
  ));
}

Future<void> getRequest() async {
  initInterceptor();
  final response = await dio.get('https://jsonplaceholder.typicode.com/users');
  if (response.statusCode == 200) {
    debugPrint('Response data ${response.data}');
  } else {
    throw Exception('Request HTTP Error, error code ${response.statusCode}');
  }
}
