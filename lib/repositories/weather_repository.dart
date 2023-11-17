import 'package:dio/dio.dart';
import 'package:flutter_weather_app/config/app_config.dart';
import 'package:flutter_weather_app/constants/api_constant.dart';
import 'package:flutter_weather_app/exceptions/exceptions.dart';
import 'package:flutter_weather_app/models/models.dart';
import 'package:flutter_weather_app/network/res_api.dart';
import 'package:flutter_weather_app/requests/requests.dart';
import 'package:flutter_weather_app/utils/parse_util.dart';

abstract class IWeatherRepository {
  Future<Current> getCurrentWeather(WeatherRequest request);
  Future<ForecastResponse> getForecast(WeatherRequest request);

  ErrorResponse checkResponseError(DioException err) {
    if (err.type == DioExceptionType.badResponse) {
      final errorData = err.response!.data as Map<String, dynamic>;
      final errorModel = ErrorResponse.fromMap(errorData);
      return errorModel;
    } else {
      return ErrorResponse(cod: '', message: '');
    }
  }
}

class WeatherRepository extends IWeatherRepository {
  WeatherRepository(this.resApi);
  late ResApi resApi;

  @override
  Future<Current> getCurrentWeather(WeatherRequest request) async {
    try {
      final res = await resApi.dio.get(
        ApiConstant.current,
        queryParameters: request.params,
      );
      final current = Current.fromMap(res.data as Map<String, dynamic>);
      return current;
    } on DioException catch (ex) {
      final res = checkResponseError(ex);
      throw ServerException(
        res.message,
        code: Parse.toIntValue(res.cod),
      );
    }
  }

  @override
  Future<ForecastResponse> getForecast(WeatherRequest request) async {
    try {
      final res = await resApi.dio.get(
        ApiConstant.forecast,
        queryParameters: request.params,
      );
      final forecast =
          ForecastResponse.fromMap(res.data as Map<String, dynamic>);
      return forecast;
    } on DioException catch (ex) {
      final res = checkResponseError(ex);
      throw ServerException(
        res.message,
        code: Parse.toIntValue(res.cod),
      );
    }
  }
}
