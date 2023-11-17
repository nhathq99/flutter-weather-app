import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_weather_app/config/app_config.dart';

const int maxCharactersPerLine = 200;

class ResApi {
  ResApi() {
    final options = BaseOptions(
      receiveTimeout: const Duration(milliseconds: 30000),
      connectTimeout: const Duration(milliseconds: 30000),
      baseUrl: AppConfig.instance.settings.baseApi,
    );
    dio = Dio(options);
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (
          RequestOptions options,
          RequestInterceptorHandler requestHandler,
        ) {
          _printLog(
            '--> ${options.method} ${options.path}',
          );
          _printLog('URI: ${options.uri}');
          _printLog('Headers ${options.headers}');
          _printLog('Data ${options.data}');
          _printLog('Query ${options.queryParameters}');
          _printLog('<-- END HTTP');
          requestHandler.next(options);
        },
        onResponse: (
          Response response,
          ResponseInterceptorHandler responseHandler,
        ) {
          _printLog(
            '<-- ${response.statusCode} ${response.requestOptions.method} ${response.requestOptions.path}',
          );
          final responseAsString = response.data.toString();
          if (responseAsString.length > maxCharactersPerLine) {
            final iterations =
                (responseAsString.length / maxCharactersPerLine).floor();
            for (var i = 0; i <= iterations; i++) {
              var endingIndex = i * maxCharactersPerLine + maxCharactersPerLine;
              if (endingIndex > responseAsString.length) {
                endingIndex = responseAsString.length;
              }
              _printLog(
                responseAsString.substring(
                  i * maxCharactersPerLine,
                  endingIndex,
                ),
              );
            }
          } else {
            _printLog(response.data.toString());
          }
          _printLog('<-- END HTTP');
          responseHandler.next(response);
        },
        onError: (
          DioException e,
          ErrorInterceptorHandler errorHandler,
        ) {
          _printLog(e.message.toString());
          errorHandler.next(e);
        },
      ),
    );
  }
  late Dio dio;

  void _printLog(String? log) {
    if (kDebugMode) {
      // ignore: avoid_print
      print(log);
    }
  }
}
