import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;
import 'package:flutter_weather_app/constants/app_constants.dart';
import 'package:flutter_weather_app/constants/app_theme.dart';
import 'package:flutter_weather_app/models/models.dart';

class WeatherItem extends StatelessWidget {
  const WeatherItem({
    required this.data,
    required this.onPressed,
    super.key,
  });
  final WeatherData data;
  final void Function(WeatherData data) onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(
        AppConstants.defaultPadding,
      ),
      color: Colors.white,
      child: InkWell(
        onTap: () => onPressed(data),
        borderRadius: BorderRadius.circular(
          AppConstants.defaultPadding,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.defaultPadding,
            vertical: AppConstants.defaultPadding / 2,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      data.current.name,
                      style: AppTheme.bodyTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    '${data.current.main.temp.toInt()}${data.unit.symbol}',
                    style: AppTheme.bodyTextStyle.copyWith(fontSize: 32),
                  ),
                ],
              ),
              const SizedBox(
                height: AppConstants.defaultPadding / 2,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      toBeginningOfSentenceCase(
                              data.current.weather[0].description) ??
                          '',
                    ),
                  ),
                  Text(
                      'H:${data.hightTemp}${data.unit.symbol} L:${data.lowTemp}${data.unit.symbol}'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
