import 'package:dartz/dartz.dart';
import 'package:homebase_weather/core/service/service_locator.dart';
import 'package:homebase_weather/feature/weather/data/model/weather_model.dart';
import 'package:homebase_weather/feature/weather/data/remote_data_sources/weather_remote_data_source.dart';
import 'package:homebase_weather/feature/weather/data/repositories/weather_repository_impl.dart';
import 'package:injectable/injectable.dart';

abstract class WeatherRepository {
  @factoryMethod
  static WeatherRepositoryImpl create(
          WeatherRemoteDataSource weatherRemoteDataSource) =>
      WeatherRepositoryImpl(weatherRemoteDataSource);
  

  Future<Either<String, WeatherModel>> fetchWeatherInformation({
    required String nameOfCity,
  }) async {
    final Either<String, WeatherModel> data = await getIt<WeatherRepositoryImpl>()
        .fetchWeatherInformation(nameOfCity: nameOfCity);
    return data.fold((l) {
      return Left(l);
    }, (r) {
      return Right(r);
    });
  }
}
