import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:homebase_weather/core/service/api_client.dart';
import 'package:homebase_weather/core/service/service_locator.config.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt', // default
  preferRelativeImports: true, // default
  asExtension: false,
)
configureDependencies({
  required Dio dio,
}) {
  getIt.registerLazySingleton<ApiClient>(() => ApiClient(
        dio,
      ));
  $initGetIt(getIt);
}
