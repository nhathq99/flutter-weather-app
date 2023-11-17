// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_weather_app/models/models.dart';
import 'package:flutter_weather_app/utils/parse_util.dart';

class Current {
  List<Weather> weather;
  Main main;
  int visibility;
  Wind wind;
  Clouds clouds;
  int dt;
  Sys sys;
  String name;
  Current({
    required this.weather,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.clouds,
    required this.dt,
    required this.sys,
    required this.name,
  });

  Current copyWith({
    List<Weather>? weather,
    Main? main,
    int? visibility,
    Wind? wind,
    Clouds? clouds,
    int? dt,
    Sys? sys,
    String? name,
  }) {
    return Current(
      weather: weather ?? this.weather,
      main: main ?? this.main,
      visibility: visibility ?? this.visibility,
      wind: wind ?? this.wind,
      clouds: clouds ?? this.clouds,
      dt: dt ?? this.dt,
      sys: sys ?? this.sys,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'weather': weather.map((x) => x.toMap()).toList(),
      'main': main.toMap(),
      'visibility': visibility,
      'wind': wind.toMap(),
      'clouds': clouds.toMap(),
      'dt': dt,
      'sys': sys.toMap(),
      'name': name,
    };
  }

  factory Current.fromMap(Map<String, dynamic> map) {
    return Current(
      weather: map['weather'] != null
          ? List<Weather>.from(
              (map['weather'] as List<dynamic>).map<Weather>(
                (x) => Weather.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
      main: Main.fromMap(
        map['main'] != null
            ? map['main'] as Map<String, dynamic>
            : <String, dynamic>{},
      ),
      visibility: Parse.toIntValue(map['visibility']),
      wind: Wind.fromMap(
        map['wind'] != null
            ? map['wind'] as Map<String, dynamic>
            : <String, dynamic>{},
      ),
      clouds: Clouds.fromMap(
        map['clouds'] != null
            ? map['clouds'] as Map<String, dynamic>
            : <String, dynamic>{},
      ),
      dt: Parse.toIntValue(map['dt']),
      sys: Sys.fromMap(
        map['sys'] != null
            ? map['sys'] as Map<String, dynamic>
            : <String, dynamic>{},
      ),
      name: Parse.toStringValue(map['name']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Current.fromJson(String source) =>
      Current.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Current(weather: $weather, main: $main, visibility: $visibility, wind: $wind, clouds: $clouds, dt: $dt, sys: $sys, name: $name)';
  }

  @override
  bool operator ==(covariant Current other) {
    if (identical(this, other)) return true;

    return other.weather == weather &&
        other.main == main &&
        other.visibility == visibility &&
        other.wind == wind &&
        other.clouds == clouds &&
        other.dt == dt &&
        other.sys == sys &&
        other.name == name;
  }

  @override
  int get hashCode {
    return weather.hashCode ^
        main.hashCode ^
        visibility.hashCode ^
        wind.hashCode ^
        clouds.hashCode ^
        dt.hashCode ^
        sys.hashCode ^
        name.hashCode;
  }
}
