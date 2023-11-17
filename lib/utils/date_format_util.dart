class DateFormatUtil {
  static String? ddMMyyyyFormat(DateTime? dateTime) {
    if (dateTime == null) {
      return null;
    }
    final year = dateTime.year;
    final month = dateTime.month;
    final day = dateTime.day;
    return '${day < 10 ? '0$day' : day}-${month < 10 ? '0$month' : month}-$year';
  }

  static String? ddMMyyyyHHmmFormat(DateTime? dateTime) {
    if (dateTime == null) {
      return null;
    }
    final year = dateTime.year;
    final month = dateTime.month;
    final day = dateTime.day;
    final hour = dateTime.hour;
    final min = dateTime.minute;
    return '${day < 10 ? '0$day' : day}-${month < 10 ? '0$month' : month}-$year ${hour < 10 ? '0$hour' : hour}:${min < 10 ? '0$min' : min}';
  }

  static String? hhmmFormat(DateTime? dateTime) {
    if (dateTime == null) {
      return null;
    }
    final hour = dateTime.hour;
    final min = dateTime.minute;
    return '${hour < 10 ? '0$hour' : hour}:${min < 10 ? '0$min' : min}';
  }

  static String iso8601Format(DateTime? dateTime) {
    if (dateTime == null) {
      return '${DateTime.now().toLocal().toIso8601String()}Z';
    }
    return '${dateTime.toLocal().toIso8601String()}Z';
  }
}
