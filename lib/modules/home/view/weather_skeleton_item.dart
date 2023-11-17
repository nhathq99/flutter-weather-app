import 'package:flutter/material.dart';
import 'package:flutter_weather_app/constants/app_constants.dart';
import 'package:flutter_weather_app/constants/app_theme.dart';

class WeatherSkeletonItem extends StatelessWidget {
  const WeatherSkeletonItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(
        AppConstants.defaultPadding,
      ),
      color: Colors.white,
      child: InkWell(
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
                      'Ho Chi Minh',
                      style: AppTheme.bodyTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    '27*C',
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
                      'Scattered clouds',
                    ),
                  ),
                  Text('H:30*C L:24*C'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
