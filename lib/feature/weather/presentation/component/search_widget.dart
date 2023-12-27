import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:homebase_weather/core/service/service_locator.dart';
import 'package:homebase_weather/core/util/app_constants.dart';
import 'package:homebase_weather/core/util/app_extension.dart';
import 'package:homebase_weather/feature/weather/data/model/weather_model.dart';
import 'package:homebase_weather/feature/weather/presentation/bloc/weather_bloc.dart';

class SearchWidget extends StatelessWidget {
  SearchWidget({super.key, 
    required this.weatherBloc,
  });
  final WeatherBloc weatherBloc;
  final _textController = TextEditingController();
  final _errorText = ValueNotifier('');
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       const Text(
          '${AppConstants.findCity} :',
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        10.vertical,
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey)),
          child: TextFormField(
            controller: _textController,
            onChanged: (value) {
              if (value.isNotEmpty) {
                _errorText.value = '';
              } else {
                _errorText.value = AppConstants.pleaseEnterCityName;
                                    weatherBloc.clearData();

              }
            },
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        10.vertical,
        Visibility(
          visible: _errorText.toString().isNotEmpty,
          child: ValueListenableBuilder(
            valueListenable: _errorText,
            builder: (BuildContext context, String value, Widget? child) {
              return Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(
                  value,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12.0,
                  ),
                ),
              );
            },
          ),
        ),
        Center(
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  primary: Color(0xFF9D52AC),
                ),
                onPressed: () async {
                  if (_textController.text.isLocationValid()) {
                    await weatherBloc.fetchWeatherInformation(
                        nameOfCity: _textController.text.trim());
                  } else {
                    _errorText.value = AppConstants.pleaseEnterCityName;
                    weatherBloc.clearData();
                  }
                },
                child: const Text('${AppConstants.searching}'),
              )),
        ),
      ],
    );
  }
}
