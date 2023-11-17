import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_weather_app/constants/app_colors.dart';
import 'package:flutter_weather_app/constants/app_constants.dart';
import 'package:flutter_weather_app/utils/parse_util.dart';

class Weather {
  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory Weather.fromMap(Map<String, dynamic> map) {
    return Weather(
      id: Parse.toIntValue(map['id']),
      main: Parse.toStringValue(map['main']),
      description: Parse.toStringValue(map['description']),
      icon: Parse.toStringValue(map['icon']),
    );
  }

  factory Weather.fromJson(String source) =>
      Weather.fromMap(json.decode(source) as Map<String, dynamic>);

  int id;
  String main;
  String description;
  String icon;

  String get fullIconUrl => AppConstants.weatherIcon(icon);

  List<Color> get colors {
    if (id > 800) {
      return AppColors.clouds;
    }
    if (id == 800) {
      return AppColors.clearSky;
    }
    if (id > 700) {
      return AppColors.atmosphere;
    }
    if (id > 600) {
      return AppColors.snow;
    }
    if (id > 500) {
      return AppColors.rain;
    }
    if (id > 300) {
      return AppColors.drizzle;
    }
    if (id > 200) {
      return AppColors.thunderstorm;
    }

    return [AppColors.melrose];
  }

  Weather copyWith({
    int? id,
    String? main,
    String? description,
    String? icon,
  }) {
    return Weather(
      id: id ?? this.id,
      main: main ?? this.main,
      description: description ?? this.description,
      icon: icon ?? this.icon,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'main': main,
      'description': description,
      'icon': icon,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Weather(id: $id, main: $main, description: $description, icon: $icon)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Weather &&
        other.id == id &&
        other.main == main &&
        other.description == description &&
        other.icon == icon;
  }

  @override
  int get hashCode {
    return id.hashCode ^ main.hashCode ^ description.hashCode ^ icon.hashCode;
  }
}
