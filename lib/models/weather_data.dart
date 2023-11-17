// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_weather_app/models/models.dart';

class WeatherData {
  Current current;
  List<Forecast> list;
  City city;
  TempUnit unit;
  WeatherData({
    required this.current,
    required this.list,
    required this.city,
    required this.unit,
  });

  int get hightTemp => _calcHightLow(true);
  int get lowTemp => _calcHightLow(false);

  int _calcHightLow(bool isHight) {
    final first8Items = list.take(8);
    var data = first8Items.map((e) => e.main).toList();
    data = [current.main, ...data];
    if (isHight) {
      final max = data.reduce(
        (cur, next) => cur.tempMax > next.tempMax ? cur : next,
      );
      return max.tempMax.toInt();
    }
    final min = data.reduce(
      (cur, next) => cur.tempMin < next.tempMax ? cur : next,
    );
    return min.tempMin.toInt();
  }
}
