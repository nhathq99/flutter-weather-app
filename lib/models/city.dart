import 'dart:convert';

import 'package:flutter_weather_app/utils/parse_util.dart';

class City {
  City({
    required this.name,
    required this.country,
    required this.sunrise,
    required this.sunset,
  });

  factory City.fromMap(Map<String, dynamic> map) {
    return City(
      name: Parse.toStringValue(map['name']),
      country: Parse.toStringValue(map['country']),
      sunrise: Parse.toIntValue(map['sunrise']),
      sunset: Parse.toIntValue(map['sunset']),
    );
  }

  String name;
  String country;
  int sunrise;
  int sunset;

  City copyWith({
    String? name,
    String? country,
    int? sunrise,
    int? sunset,
  }) {
    return City(
      name: name ?? this.name,
      country: country ?? this.country,
      sunrise: sunrise ?? this.sunrise,
      sunset: sunset ?? this.sunset,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'country': country,
      'sunrise': sunrise,
      'sunset': sunset,
    };
  }

  String toJson() => json.encode(toMap());

  factory City.fromJson(String source) =>
      City.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Sys(name: $name, country: $country, sunrise: $sunrise, sunset: $sunset)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is City &&
        other.name == name &&
        other.country == country &&
        other.sunrise == sunrise &&
        other.sunset == sunset;
  }

  @override
  int get hashCode =>
      name.hashCode ^ country.hashCode ^ sunrise.hashCode ^ sunset.hashCode;
}
