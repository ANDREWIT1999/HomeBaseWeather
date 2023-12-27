import 'package:dartz/dartz.dart';
import 'package:homebase_weather/feature/weather/data/model/weather_model.dart';
import 'package:homebase_weather/feature/weather/domain/repositories/weather_repository.dart';

class WeatherUseCase {
  late WeatherRepository _userRepository;
  WeatherUseCase(WeatherRepository userRepository) {
    _userRepository = userRepository;
  }
  Future<Either<String, WeatherModel>> fetchWeatherInformation(
      {required String nameOfCity}) async {
    return await _userRepository.fetchWeatherInformation(nameOfCity:nameOfCity);
  }
}
