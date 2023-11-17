class TempUnit {
  TempUnit(
      {required this.name,
      required this.unit,
      required this.symbol,
      required this.speedUnit,});

  String name;
  String unit;
  String symbol;
  String speedUnit;

  static List<TempUnit> get tempUnits => [
        TempUnit(
          name: 'Celsius',
          unit: 'metric',
          symbol: '°C',
          speedUnit: 'meter/sec',
        ),
        TempUnit(
          name: 'Fahrenheit',
          unit: 'imperial',
          symbol: '°F',
          speedUnit: 'miles/hour',
        ),
      ];
}
