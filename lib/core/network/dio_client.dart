import 'package:dio/dio.dart';

class DioClient {
  static Dio init() {
    final options = BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    );

    final dio = Dio(options);
    return dio;
  }
}
