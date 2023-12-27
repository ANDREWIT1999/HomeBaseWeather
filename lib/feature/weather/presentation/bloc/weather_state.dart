

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:homebase_weather/feature/weather/data/model/weather_model.dart';
import 'package:homebase_weather/feature/weather/presentation/bloc/weather_bloc.dart';

part 'weather_state.freezed.dart';

@freezed
class WeatherState with _$WeatherState{
  factory WeatherState({StateObject<WeatherModel>? stateObject}) = _WeatherState;
}