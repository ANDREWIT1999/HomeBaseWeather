// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../feature/weather/data/remote_data_sources/weather_remote_data_source.dart'
    as _i4;
import '../../feature/weather/data/repositories/weather_repository_impl.dart'
    as _i7;
import '../../feature/weather/domain/repositories/weather_repository.dart'
    as _i6;
import '../../feature/weather/domain/usecases/weather_usecase.dart' as _i8;
import '../../feature/weather/presentation/bloc/weather_bloc.dart' as _i9;
import 'api_client.dart' as _i5;
import 'dio_service.dart' as _i3;

// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.factory<_i3.DioService>(() => _i3.DioService());
  gh.factory<_i4.WeatherRemoteDataSource>(
      () => _i4.WeatherRemoteDataSource(gh<_i5.ApiClient>()));
  gh.factory<_i6.WeatherRepository>(
      () => _i7.WeatherRepositoryImpl(gh<_i4.WeatherRemoteDataSource>()));
  gh.factory<_i8.WeatherUseCase>(
      () => _i8.WeatherUseCase(gh<_i6.WeatherRepository>()));
  gh.factory<_i9.WeatherBloc>(() => _i9.WeatherBloc(gh<_i8.WeatherUseCase>()));
  return getIt;
}
