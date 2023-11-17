import 'package:flutter_weather_app/modules/home/home.dart';
import 'package:flutter_weather_app/network/res_api.dart';
import 'package:flutter_weather_app/repositories/repositories.dart';
import 'package:get_it/get_it.dart';

final injector = GetIt.I;

Future<void> configureDI() async {
  await injectNetwork();
  await injectData();
  await injectBloc();
}

Future<void> injectNetwork() async {
  injector.registerLazySingleton(
    ResApi.new,
  );
}

Future<void> injectData() async {
  injector.registerLazySingleton(
    () => WeatherRepository(
      injector.get<ResApi>(),
    ),
  );
}

Future<void> injectBloc() async {
  injector.registerFactory(
    () => HomeCubit(
      weatherRepository: injector.get<WeatherRepository>(),
    ),
  );
}
