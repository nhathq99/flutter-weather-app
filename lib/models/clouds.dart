import 'dart:convert';

import 'package:flutter_weather_app/utils/parse_util.dart';

class Clouds {
  Clouds({
    required this.all,
  });

  factory Clouds.fromMap(Map<String, dynamic> map) {
    return Clouds(
      all: Parse.toIntValue(map['all']),
    );
  }

  int all;

  Clouds copyWith({
    int? all,
  }) {
    return Clouds(
      all: all ?? this.all,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'all': all,
    };
  }

  String toJson() => json.encode(toMap());

  factory Clouds.fromJson(String source) =>
      Clouds.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Clouds(all: $all)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Clouds && other.all == all;
  }

  @override
  int get hashCode => all.hashCode;
}
