// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_weather_app/models/models.dart';
import 'package:flutter_weather_app/utils/parse_util.dart';

class Forecast {
  int dt;
  Main main;
  List<Weather> weather;
  Clouds clouds;
  Wind wind;
  int visibility;
  Rain rain;
  String dtText;
  Forecast({
    required this.dt,
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.visibility,
    required this.rain,
    required this.dtText,
  });

  Forecast copyWith({
    int? dt,
    Main? main,
    List<Weather>? weather,
    Clouds? clouds,
    Wind? wind,
    int? visibility,
    Rain? rain,
    String? dtText,
  }) {
    return Forecast(
      dt: dt ?? this.dt,
      main: main ?? this.main,
      weather: weather ?? this.weather,
      clouds: clouds ?? this.clouds,
      wind: wind ?? this.wind,
      visibility: visibility ?? this.visibility,
      rain: rain ?? this.rain,
      dtText: dtText ?? this.dtText,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dt': dt,
      'main': main.toMap(),
      'weather': weather.map((x) => x.toMap()).toList(),
      'clouds': clouds.toMap(),
      'wind': wind.toMap(),
      'visibility': visibility,
      'rain': rain.toMap(),
      'dtTxt': dtText,
    };
  }

  factory Forecast.fromMap(Map<String, dynamic> map) {
    return Forecast(
      dt: Parse.toIntValue(map['dt']),
      main: Main.fromMap(
        map['main'] != null
            ? map['main'] as Map<String, dynamic>
            : <String, dynamic>{},
      ),
      weather: map['weather'] != null
          ? List<Weather>.from(
              (map['weather'] as List<dynamic>).map<Weather>(
                (x) => Weather.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
      clouds: Clouds.fromMap(
        map['clouds'] != null
            ? map['clouds'] as Map<String, dynamic>
            : <String, dynamic>{},
      ),
      wind: Wind.fromMap(
        map['wind'] != null
            ? map['wind'] as Map<String, dynamic>
            : <String, dynamic>{},
      ),
      visibility: Parse.toIntValue(map['visibility']),
      rain: Rain.fromMap(
        map['rain'] != null
            ? map['rain'] as Map<String, dynamic>
            : <String, dynamic>{},
      ),
      dtText: Parse.toStringValue(map['dt_txt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Forecast.fromJson(String source) =>
      Forecast.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Forecast(dt: $dt, main: $main, weather: $weather, clouds: $clouds, wind: $wind, visibility: $visibility, rain: $rain, dtText: $dtText)';
  }

  @override
  bool operator ==(covariant Forecast other) {
    if (identical(this, other)) return true;

    return other.dt == dt &&
        other.main == main &&
        other.weather == weather &&
        other.clouds == clouds &&
        other.wind == wind &&
        other.visibility == visibility &&
        other.rain == rain &&
        other.dtText == dtText;
  }

  @override
  int get hashCode {
    return dt.hashCode ^
        main.hashCode ^
        weather.hashCode ^
        clouds.hashCode ^
        wind.hashCode ^
        visibility.hashCode ^
        rain.hashCode ^
        dtText.hashCode;
  }
}
