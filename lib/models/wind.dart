import 'dart:convert';

import 'package:flutter_weather_app/utils/parse_util.dart';

class Wind {
  Wind({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  factory Wind.fromMap(Map<String, dynamic> map) {
    return Wind(
      speed: Parse.toDoubleValue(map['speed']),
      deg: Parse.toIntValue(map['deg']),
      gust: Parse.toDoubleValue(map['gust']),
    );
  }

  double speed;
  int deg;
  double gust;

  Wind copyWith({
    double? speed,
    int? deg,
    double? gust,
  }) {
    return Wind(
      speed: speed ?? this.speed,
      deg: deg ?? this.deg,
      gust: gust ?? this.gust,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'speed': speed,
      'deg': deg,
      'gust': gust,
    };
  }

  String toJson() => json.encode(toMap());

  factory Wind.fromJson(String source) =>
      Wind.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Wind(speed: $speed, deg: $deg, gust: $gust)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Wind &&
        other.speed == speed &&
        other.deg == deg &&
        other.gust == gust;
  }

  @override
  int get hashCode => speed.hashCode ^ deg.hashCode ^ gust.hashCode;
}
