import 'package:dio/dio.dart';
import 'package:homebase_weather/core/service/custom_interceptors.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioService {
  DioService();
  static Dio initDioService() {
    final dio = Dio();
    dio.options.baseUrl = 'https://api.openweathermap.org/data/2.5/';
  dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers['Accept'] = 'application/json';
    dio.options.baseUrl;
    dio.interceptors.add(CustomInterceptors());
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
    return dio;
  }
}
