// ignore_for_file: public_member_api_docs, sort_constructors_first
class WeatherRequest {
  WeatherRequest({
    required this.units,
    required this.query,
    required this.appid,
  });
  String units;
  String query;
  String appid;

  Map<String, dynamic> get params => {
    'units': units,
    'q': query,
    'APPID': appid,
  };
}
