import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gtext/gtext.dart';
import 'package:homebase_weather/core/service/dio_service.dart';
import 'package:homebase_weather/feature/weather/presentation/screen/weather_screen.dart';
import 'package:translator/translator.dart';

import 'core/service/service_locator.dart';

void main() {
  asynData();

  configureDependencies(
    dio: DioService.initDioService(),
  );
  runApp(const MyApp());
}

Future<void> asynData() async {
  await dotenv.load();
      GText.init(from: 'en' ,to: 'vi', enableCaching: false);

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const WeatherScreen(),
    );
  }
}
