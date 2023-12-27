import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homebase_weather/core/app_assets_gen/assets.gen.dart';
import 'package:homebase_weather/core/common_widget/loading_shimmer.dart';
import 'package:homebase_weather/core/util/app_constants.dart';
import 'package:homebase_weather/core/util/app_extension.dart';
import 'package:homebase_weather/feature/weather/data/model/weather_model.dart';
import 'package:homebase_weather/feature/weather/presentation/bloc/weather_bloc.dart';
import 'package:homebase_weather/feature/weather/presentation/bloc/weather_state.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:translator/translator.dart';

class InformationWidget extends StatefulWidget {
  const InformationWidget({
    super.key,
  });

  @override
  State<InformationWidget> createState() => _InformationWidgetState();
}

class _InformationWidgetState extends State<InformationWidget> {
  String _formattedDate = '';
  final _textstyle = const TextStyle(color: Colors.white, fontSize: 20);

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    DateTime date = DateTime.now();
    _formattedDate = DateFormat.yMMMMd('vi_VN').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, weatherState) {
      switch (weatherState.stateObject?.loadState ?? LoadState.error) {
        case LoadState.init:
          return const SizedBox.shrink();
        case LoadState.loading:
          return const LoadingShimmer();
        case LoadState.loaded:
              final data = weatherState.stateObject?.data as WeatherModel ;
          return _buildInformation(data);
        case LoadState.error:
          return _buildErrorWidget(weatherState.stateObject);
      }
    });
  }

  Container _buildErrorWidget(StateObject<dynamic>? stateBloc) {
    return Container(
        margin: const EdgeInsets.only(top: 80),
        child: Text(
          stateBloc?.message ?? '',
          style: TextStyle(
            color: Colors.red,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ));
  }

  Container _buildInitWidget() {
    return Container(
        margin: EdgeInsets.only(top: 80),
        child: const Text(
          AppConstants.dontHaveResult,
          style: TextStyle(
            color: Colors.red,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ));
  }

  Column _buildInformation(WeatherModel? data) {
    return Column(
      children: [
        30.vertical,
        Text(
          ' ${(data?.main?.temp ?? 0).celsius?.round()}°',
          textAlign: TextAlign.center,
          style: _textstyle.copyWith(
            fontSize: 64,
            fontWeight: FontWeight.w500,
          ),
        ),
        10.vertical,
        Text(
          '${data?.weather?[0].description}',
          style: _textstyle.copyWith(fontWeight: FontWeight.w800),
        ),
        10.vertical,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${AppConstants.hight}: ${(data?.main?.tempMax ?? 0).celsius?.round()}°',
              style: _textstyle.copyWith(fontWeight: FontWeight.w500),
            ),
            5.horizontal,
            Text(
              '${AppConstants.low}: ${(data?.main?.tempMin ?? 0).celsius?.round()}°',
              style: _textstyle.copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        20.vertical,
        Container(
          width: 428,
          height: 246,
          padding:const EdgeInsets.symmetric(horizontal: 20),
          decoration: ShapeDecoration(
            gradient:const LinearGradient(
              begin: Alignment(-0.76, -0.65),
              end: Alignment(0.76, 0.65),
              colors:  [
                Color(0xFF9D52AC),
                Color(0xFF3E2D8F),
              ],
            ),
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Color(0xFFF7CBFD)),
              borderRadius: BorderRadius.circular(30),
            ),
            shadows: const  [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 4,
                offset: Offset(0, 1),
                spreadRadius: 0,
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.vertical,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppConstants.today,
                    style: _textstyle,
                  ),
                  Text(
                    _formattedDate,
                    style: _textstyle,
                  ),
                ],
              ),
              20.vertical,
              Divider(color: Colors.white),
              _buildIcon(
                  image: Assets.images.windSpeed.image(),
                  text: '${AppConstants.windSpeed}: ${data?.wind?.speed} m/s'),
              _buildIcon(
                  image: Assets.images.humidity.image(),
                  text: '${AppConstants.humidity}: ${data?.main?.humidity} %'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIcon({
    required Widget image,
    required String text,
  }) {
    return Row(
      children: [
        image,
        10.horizontal,
        Text(
          text,
          style: _textstyle.copyWith(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
