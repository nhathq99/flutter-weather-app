import 'dart:convert';

import 'package:flutter_weather_app/utils/parse_util.dart';

class Sys {
  Sys({
    required this.country,
    required this.sunrise,
    required this.sunset,
  });

  factory Sys.fromMap(Map<String, dynamic> map) {
    return Sys(
      country: Parse.toStringValue(map['country']),
      sunrise: Parse.toIntValue(map['sunrise']),
      sunset: Parse.toIntValue(map['sunset']),
    );
  }

  String country;
  int sunrise;
  int sunset;

  Sys copyWith({
    String? country,
    int? sunrise,
    int? sunset,
  }) {
    return Sys(
      country: country ?? this.country,
      sunrise: sunrise ?? this.sunrise,
      sunset: sunset ?? this.sunset,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'country': country,
      'sunrise': sunrise,
      'sunset': sunset,
    };
  }

  String toJson() => json.encode(toMap());

  factory Sys.fromJson(String source) =>
      Sys.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Sys(country: $country, sunrise: $sunrise, sunset: $sunset)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Sys &&
        other.country == country &&
        other.sunrise == sunrise &&
        other.sunset == sunset;
  }

  @override
  int get hashCode => country.hashCode ^ sunrise.hashCode ^ sunset.hashCode;
}
