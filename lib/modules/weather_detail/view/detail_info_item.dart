import 'package:flutter/material.dart';
import 'package:flutter_weather_app/constants/app_colors.dart';
import 'package:flutter_weather_app/constants/app_constants.dart';

class DetailInfoItem extends StatelessWidget {
  const DetailInfoItem({
    required this.title,
    required this.value,
    super.key,
  });
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppConstants.defaultPadding / 2,
          horizontal: AppConstants.defaultPadding / 2,
        ),
        decoration: BoxDecoration(
          color: AppColors.melrose,
          borderRadius: BorderRadius.circular(
            AppConstants.defaultPadding,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            const SizedBox(
              height: AppConstants.defaultPadding / 4,
            ),
            Text(value),
          ],
        ),
      ),
    );
  }
}
