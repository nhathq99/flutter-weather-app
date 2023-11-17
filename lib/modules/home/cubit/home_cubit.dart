import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_weather_app/config/app_config.dart';
import 'package:flutter_weather_app/models/models.dart';
import 'package:flutter_weather_app/repositories/repositories.dart';
import 'package:flutter_weather_app/requests/requests.dart';
import 'package:flutter_weather_app/utils/storage_util.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.weatherRepository}) : super(const HomeState());

  final WeatherRepository weatherRepository;

  Future<void> initialData({bool isRefresh = false, int? unitIndex}) async {
    try {
      if (isRefresh) {
        final state = this.state.copyWith(status: DataStatus.initial);
        emit(state);
      }
      final unit = TempUnit.tempUnits[unitIndex ?? this.state.selectedUnit];
      final key = AppConfig.instance.settings.openWeatherMapKey;
      final savedLocations = await StorageUtil.getSavedLocations();

      final requests = savedLocations.map((val) {
        final request = WeatherRequest(
          units: unit.unit,
          query: val,
          appid: key,
        );
        final current = weatherRepository.getCurrentWeather(request);
        final forecast = weatherRepository.getForecast(request);
        return Future.wait([current, forecast]);
      }).toList();

      final responses = await Future.wait(requests);

      final data = responses.map((item) {
        final current = item[0] as Current;
        final forecast = item[1] as ForecastResponse;
        return WeatherData(
          current: current,
          list: forecast.list,
          city: forecast.city,
          unit: unit,
        );
      }).toList();

      final state = this.state.copyWith(
            list: data,
            selectedUnit: unitIndex,
            status: DataStatus.success,
          );
      emit(state);
    } catch (error) {
      final state = this.state.copyWith(
            status: DataStatus.failure,
            error: error is Exception ? error : Exception(error),
          );
      emit(state);
    }
  }

  Future<void> onSubmitted(String val) async {
    try {
      var state = this.state.copyWith(status: DataStatus.loading);
      emit(state);
      final unit = TempUnit.tempUnits[this.state.selectedUnit];
      final key = AppConfig.instance.settings.openWeatherMapKey;
      final request = WeatherRequest(
        units: unit.unit,
        query: val.trim(),
        appid: key,
      );
      final currentReq = weatherRepository.getCurrentWeather(request);
      final forecastReq = weatherRepository.getForecast(request);
      final response = await Future.wait([currentReq, forecastReq]);
      final currentRes = response[0] as Current;
      final forecastRes = response[1] as ForecastResponse;
      final data = WeatherData(
        current: currentRes,
        list: forecastRes.list,
        city: forecastRes.city,
        unit: unit,
      );
      var locations = await StorageUtil.getSavedLocations();
      locations = [val.trim(), ...locations];
      StorageUtil.storeLocations(locations);
      final list = [data, ...this.state.list];
      state = this.state.copyWith(
            list: list,
            status: DataStatus.success,
          );
      emit(state);
    } catch (error) {
      final state = this.state.copyWith(
            status: DataStatus.failurePopup,
            error: error is Exception ? error : Exception(error),
          );
      emit(state);
    }
  }

  void onChangeUnit(int index) {
    initialData(isRefresh: true, unitIndex: index);
  }

}
