import 'dart:convert';

import 'package:flutter_weather_app/utils/parse_util.dart';

class Rain {
  Rain({
    required this.threeHour,
  });

  factory Rain.fromMap(Map<String, dynamic> map) {
    return Rain(
      threeHour: Parse.toIntValue(map['3h']),
    );
  }

  int threeHour;

  Rain copyWith({
    int? threeHour,
  }) {
    return Rain(
      threeHour: threeHour ?? this.threeHour,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '3h': threeHour,
    };
  }

  String toJson() => json.encode(toMap());

  factory Rain.fromJson(String source) =>
      Rain.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Rain(3h: $threeHour)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Rain && other.threeHour == threeHour;
  }

  @override
  int get hashCode => threeHour.hashCode;
}
