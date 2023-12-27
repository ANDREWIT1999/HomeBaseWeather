import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:homebase_weather/core/service/api_client.dart';
import 'package:homebase_weather/feature/weather/data/model/weather_model.dart';

class WeatherRemoteDataSource {
  late ApiClient _apiClient;
  WeatherRemoteDataSource(ApiClient restClient) {
    _apiClient = restClient;
  }
  Future<Either<String, WeatherModel>> fetchWeatherInformation({
    required String nameOfCity,
  }) async {
    try {
      final data = await _apiClient.fetchWeatherInformation(
          nameOfCity, dotenv.get('API_KEY'));
      return Right(data);
    } catch (error) {
      var errorMessage = '';
      if (error is DioError) {
        if (error.response != null) {
          if (error.response?.data != null && error.response?.data is Map) {
            var responseData = error.response?.data;
            if (responseData.containsKey('message')) {
               errorMessage = responseData['message'];
            }
          }
        }
      }
      return Left(errorMessage.toString());
    }
  }
}
