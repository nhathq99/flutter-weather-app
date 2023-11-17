import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;
import 'package:flutter_weather_app/constants/app_constants.dart';
import 'package:flutter_weather_app/models/models.dart';
import 'package:flutter_weather_app/utils/date_format_util.dart';
import 'package:flutter_weather_app/utils/image_util.dart';

class ThreeHoursForecastItem extends StatelessWidget {
  const ThreeHoursForecastItem({
    required this.forecast,
    required this.unit,
    super.key,
  });
  final Forecast forecast;
  final TempUnit unit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.defaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          AppConstants.defaultPadding,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormatUtil.ddMMyyyyHHmmFormat(
                        DateTime.fromMillisecondsSinceEpoch(forecast.dt * 1000),
                      ) ??
                      '',
                ),
                Text(
                  toBeginningOfSentenceCase(forecast.weather[0].description) ??
                      '',
                ),
              ],
            ),
          ),
          Text(
            '${forecast.main.temp.toInt()}${unit.symbol}',
          ),
          Expanded(
            flex: 2,
            child: ImageUtil.loadNetWorkImage(
              url: forecast.weather[0].fullIconUrl,
              fit: BoxFit.fitWidth,
            ),
          ),
        ],
      ),
    );
  }
}
