import 'dart:math';

import 'package:intl/intl.dart';

abstract class Parse {
  static int toIntValue(dynamic value, {int defaultValue = 0}) {
    if (value is int) {
      return value;
    }
    if (value is double) {
      if (value.isNaN || value.isInfinite) {
        return defaultValue;
      }
      return value.toInt();
    }
    if (value is String) {
      return int.tryParse(value) ?? defaultValue;
    }
    return defaultValue;
  }

  static double toDoubleValue(dynamic value, {double defaultValue = 0}) {
    if (value is int) {
      return value.toDouble();
    }
    if (value is double) {
      return value;
    }
    if (value is String) {
      return double.tryParse(value) ?? defaultValue;
    }
    return defaultValue;
  }

  static String toStringValue(dynamic value, {String defaultValue = ''}) {
    if (value is int) {
      return value.toString();
    }
    if (value is double) {
      return value.toString();
    }
    if (value is String) {
      return value;
    }
    return defaultValue;
  }

  static bool toBoolValue(dynamic value, {bool defaultValue = false}) {
    if (value is bool) {
      return value;
    }
    if (value is String) {
      if (value == 'true') {
        return true;
      } else {
        return false;
      }
    }
    return defaultValue;
  }

  static String toDateStringValue(dynamic value, {String defaultValue = ''}) {
    if (value is String) {
      try {
        final tempDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
            .parse(value); //"2022-01-06T09:25:01.19Z"
        final date = DateFormat('dd/MM/yyyy').format(tempDate);
        return date;
      } catch (ex) {
        return value;
      }
    }
    return defaultValue;
  }

  static String roundThreeDoubleValue(double value) {
    final rounded = value * 100 * 1000;
    return (rounded.round() / 1000).toString();
  }

  static double roundThreeDoubleToDouble(double value) {
    final rounded = value * 1000;
    return rounded.round() / 1000;
  }

  static String removeTrailingDoubleToString(double value) {
    return value.toString().replaceAll(RegExp(r'([.]*0)(?!.*\d)'), '');
  }

  static double floorDoubleSixDecimal(String value) {
    final  db = (toDoubleValue(value) * pow(10, 6)).floor().toDouble();
    return db / pow(10, 6);
  }

  static double floorDoubleWithDecimals(String amount, int decimals) {
    if (decimals == 0) {
      return toDoubleValue(amount);
    }
    final  result = toDoubleValue(amount) / pow(10, decimals);
    return floorDoubleSixDecimal(result.toString());
  }

  static double roundDoubleSixDecimals(double value) {
    return (value * pow(10, 6)).round() / pow(10, 6);
  }

  static double doubleToPrecision(double value, int fractionDigits) {
    final mod = pow(10, fractionDigits.toDouble());
    return (value * mod).round().toDouble() / mod;
  }
}
