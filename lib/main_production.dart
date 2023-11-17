import 'package:flutter_weather_app/bootstrap.dart';
import 'package:flutter_weather_app/config/app_config.dart';
import 'package:flutter_weather_app/modules/app/app.dart';

void main() {
  bootstrap(Flavor.production, () => const App());
}
