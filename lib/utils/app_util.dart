import 'package:flutter/foundation.dart';
import 'package:flutter_weather_app/config/app_config.dart';

class AppUtil {
  static void printLog(String message) {
    if (AppConfig.instance.flavor == Flavor.production && !kDebugMode) {
      return;
    }

    // ignore: avoid_print
    print(message);
  }

  static DateTime nowDateOnly() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  static List<DateTime> todayEvery3Hours() {
    final dates = <DateTime>[];
    for (var i = 1; i <= 8; i++) {
      final now = nowDateOnly();
      final date = now.add(Duration(hours: i * 3));
      dates.add(date);
    }
    return dates;
  }

  static List<int> todayEvery3HoursTimeStamp() {
    final dates = todayEvery3Hours();
    final converted = dates.map((e) => e.millisecondsSinceEpoch).toList();
    return converted;
  }
}
