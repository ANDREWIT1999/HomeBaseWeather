import 'package:dio/dio.dart';
import 'package:homebase_weather/feature/weather/data/model/weather_model.dart';
import 'package:retrofit/http.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET("weather")
  Future<WeatherModel> fetchWeatherInformation(
  @Query("q") String cityName,
  @Query("appid") String apiKey,
);
}
