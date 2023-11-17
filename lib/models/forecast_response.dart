// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:flutter_weather_app/models/city.dart';
import 'package:flutter_weather_app/models/forecast.dart';

class ForecastResponse {
  String cod;
  dynamic message;
  int cnt;
  List<Forecast> list;
  City city;
  ForecastResponse({
    required this.cod,
    required this.message,
    required this.cnt,
    required this.list,
    required this.city,
  });

  ForecastResponse copyWith({
    String? cod,
    dynamic message,
    int? cnt,
    List<Forecast>? list,
    City? city,
  }) {
    return ForecastResponse(
      cod: cod ?? this.cod,
      message: message ?? this.message,
      cnt: cnt ?? this.cnt,
      list: list ?? this.list,
      city: city ?? this.city,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cod': cod,
      'message': message,
      'cnt': cnt,
      'list': list.map((x) => x.toMap()).toList(),
      'city': city.toMap(),
    };
  }

  factory ForecastResponse.fromMap(Map<String, dynamic> map) {
    return ForecastResponse(
      cod: map['cod'] as String,
      message: map['message'] as dynamic,
      cnt: map['cnt'] as int,
      list: map['list'] != null
          ? List<Forecast>.from(
              (map['list'] as List<dynamic>).map<Forecast>(
                (x) => Forecast.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
      city: City.fromMap(
        map['city'] != null
            ? map['city'] as Map<String, dynamic>
            : <String, dynamic>{},
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ForecastResponse.fromJson(String source) =>
      ForecastResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ForecastResponse(cod: $cod, message: $message, cnt: $cnt, list: $list, city: $city)';
  }

  @override
  bool operator ==(covariant ForecastResponse other) {
    if (identical(this, other)) return true;

    return other.cod == cod &&
        other.message == message &&
        other.cnt == cnt &&
        listEquals(other.list, list) &&
        other.city == city;
  }

  @override
  int get hashCode {
    return cod.hashCode ^
        message.hashCode ^
        cnt.hashCode ^
        list.hashCode ^
        city.hashCode;
  }
}
