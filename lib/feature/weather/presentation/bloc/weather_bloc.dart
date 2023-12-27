import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homebase_weather/feature/weather/data/model/weather_model.dart';
import 'package:homebase_weather/feature/weather/domain/usecases/weather_usecase.dart';
import 'package:homebase_weather/feature/weather/presentation/bloc/weather_state.dart';
import 'package:translator/translator.dart';

enum LoadState { init, loading, loaded, error }

class StateObject<T> {
  final LoadState loadState;
  final T? data;
  final String? message;

  StateObject({required this.loadState, this.data, this.message});
}

class WeatherBloc extends Cubit<WeatherState> {
  late WeatherUseCase _useCase;
  WeatherBloc(WeatherUseCase useCase) : super(WeatherState()) {
    _useCase = useCase;
  }
  Future<void> fetchWeatherInformation({required String nameOfCity}) async {
    final translator = GoogleTranslator();
    emit(state.copyWith(
        stateObject: StateObject(
      loadState: LoadState.loading,
    )));
    final data = await _useCase.fetchWeatherInformation(nameOfCity: nameOfCity);
    return data.fold((failure) async {
      await translator.translate(failure, from: 'en', to: 'vi').then((value) {
        emit(state.copyWith(
            stateObject:
                StateObject(loadState: LoadState.error, message: value.text)));
      });
    }, (data) async {
      await translator
          .translate(data.weather?[0].description ?? '', from: 'en', to: 'vi')
          .then((value) {
        data.weather?[0].description = _capitalizedText(value.text);
      });

      emit(state.copyWith(
          stateObject: StateObject<WeatherModel>(
              loadState: LoadState.loaded, data: data)));
    });
  }

  void clearData() {
      emit(state.copyWith(
          stateObject: StateObject<WeatherModel>(
              loadState: LoadState.init, )));
  }
  String _capitalizedText(String text) {
  return text.split(' ').map((word) {
    if (word.isNotEmpty) {
      return word[0].toUpperCase() + word.substring(1);
    }
    return '';
  }).join(' ');
}

}

