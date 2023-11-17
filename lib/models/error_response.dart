// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_weather_app/utils/parse_util.dart';

class ErrorResponse {
  String cod;
  String message;
  ErrorResponse({
    required this.cod,
    required this.message,
  });

  ErrorResponse copyWith({
    String? cod,
    String? message,
  }) {
    return ErrorResponse(
      cod: cod ?? this.cod,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cod': cod,
      'message': message,
    };
  }

  factory ErrorResponse.fromMap(Map<String, dynamic> map) {
    return ErrorResponse(
      cod: Parse.toStringValue(map['cod']),
      message: Parse.toStringValue(map['message']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ErrorResponse.fromJson(String source) =>
      ErrorResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ErrorResponse(cod: $cod, message: $message)';

  @override
  bool operator ==(covariant ErrorResponse other) {
    if (identical(this, other)) return true;

    return other.cod == cod && other.message == message;
  }

  @override
  int get hashCode => cod.hashCode ^ message.hashCode;
}
