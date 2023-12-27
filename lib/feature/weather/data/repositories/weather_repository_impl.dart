import 'package:dartz/dartz.dart';
import 'package:homebase_weather/feature/weather/data/model/weather_model.dart';
import 'package:homebase_weather/feature/weather/data/remote_data_sources/weather_remote_data_source.dart';
import 'package:homebase_weather/feature/weather/domain/repositories/weather_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: WeatherRepository)
class WeatherRepositoryImpl extends WeatherRepository{
  late WeatherRemoteDataSource _weatherRemoteDataSource;
  WeatherRepositoryImpl(WeatherRemoteDataSource weatherRemoteDataSource) {
    _weatherRemoteDataSource = weatherRemoteDataSource;
  }

  @override
  Future<Either<String, WeatherModel>> fetchWeatherInformation({required String nameOfCity,
  }) async {
    final Either<String, WeatherModel> data =
        await _weatherRemoteDataSource.fetchWeatherInformation(nameOfCity:nameOfCity);
    return data.fold((l) {
      return Left(l);
    }, (r) {
     
      return Right(r );
    });
  }
}
