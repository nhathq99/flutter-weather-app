enum Flavor {
  development,
  staging,
  production,
}

class AppConfig {
  factory AppConfig({
    required Flavor flavor,
    required FlavorSettings settings,
  }) {
    _instance ??= AppConfig._(flavor, settings);
    return _instance!;
  }

  AppConfig._(
    this.flavor,
    this.settings,
  );

  factory AppConfig.createByFlavor({required Flavor flavor}) {
    switch (flavor) {
      case Flavor.development:
        return AppConfig(
          flavor: flavor,
          settings: FlavorSettings.development(),
        );
      case Flavor.staging:
        return AppConfig(
          flavor: flavor,
          settings: FlavorSettings.staging(),
        );
      case Flavor.production:
        return AppConfig(
          flavor: flavor,
          settings: FlavorSettings.production(),
        );
      default:
        throw Exception('Invalid Flavor');
    }
  }
  final Flavor flavor;
  final FlavorSettings settings;

  static AppConfig? _instance;
  static AppConfig get instance => _instance!;
}

class FlavorSettings {
  FlavorSettings.development()
      : appName = 'Weather Dev',
        baseApi = 'https://api.openweathermap.org/data/2.5',
        openWeatherMapKey = 'abed706a1ffed905b6755fc7618fcad3';

  FlavorSettings.staging()
      : appName = 'Weather Stag',
        baseApi = 'https://api.openweathermap.org/data/2.5',
        openWeatherMapKey = 'abed706a1ffed905b6755fc7618fcad3';

  FlavorSettings.production()
      : appName = 'Weather',
        baseApi = 'https://api.openweathermap.org/data/2.5',
        openWeatherMapKey = 'abed706a1ffed905b6755fc7618fcad3';

  final String appName;
  final String baseApi;
  final String openWeatherMapKey;
}
