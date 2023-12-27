import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:homebase_weather/core/app_assets_gen/assets.gen.dart';
import 'package:homebase_weather/core/util/app_constants.dart';
import 'package:homebase_weather/core/common_widget/base_app_bar.dart';
import 'package:homebase_weather/core/service/service_locator.dart';
import 'package:homebase_weather/core/util/app_extension.dart';
import 'package:homebase_weather/feature/weather/presentation/bloc/weather_bloc.dart';
import 'package:homebase_weather/feature/weather/presentation/bloc/weather_state.dart';
import 'package:homebase_weather/feature/weather/presentation/component/information_widget.dart';
import 'package:homebase_weather/feature/weather/presentation/component/search_widget.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final _weatherBloc = getIt<WeatherBloc>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _weatherBloc,
      child: Scaffold(
        appBar: BaseAppBar(
          elevation: 0,
          backgroundColor: Colors.blue.shade100,
          leadingWidth: double.infinity,
          leading: Container(
            margin: const EdgeInsets.only(left: 15),
            child: const Text(
              AppConstants.homeBaseWeather,
              style: TextStyle(color: Colors.green,fontSize: 30,fontWeight: FontWeight.bold,),
            ),
          ),
        ),
        body: Container(
          color: Colors.blue.shade100,
          height: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(children: [
            
              SearchWidget(weatherBloc: _weatherBloc),
             const InformationWidget(),
            ]),
          ),
        ),
      ),
    );
  }
}

