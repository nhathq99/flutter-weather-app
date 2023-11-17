import 'package:flutter/material.dart';
import 'package:flutter_weather_app/constants/app_colors.dart';
import 'package:flutter_weather_app/constants/app_constants.dart';
import 'package:flutter_weather_app/constants/app_theme.dart';
import 'package:flutter_weather_app/utils/image_util.dart';
import 'package:flutter_weather_app/widgets/primary_button.dart';

class OnboardingTab extends StatelessWidget {
  const OnboardingTab({
    required this.data,
    this.onButtonPressed,
    super.key,
  });
  final OnboardingData data;
  final void Function()? onButtonPressed;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Container(
          height: height * 0.7,
          width: width,
          decoration: BoxDecoration(
              color: AppColors.melrose,
              borderRadius: BorderRadius.only(
                bottomLeft: data.isFirstPage
                    ? Radius.circular(width * 0.25)
                    : Radius.zero,
                bottomRight: data.isLastPage
                    ? Radius.circular(width * 0.25)
                    : Radius.zero,
              )),
        ),
        Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: ImageUtil.loadAssetsImage(
                      width: 200,
                      height: 200,
                      assetPath: data.img,
                    ),
                  ),
                  const SizedBox(height: AppConstants.defaultPadding * 2),
                  Text(
                    data.desc,
                    style: AppTheme.headerTextStyle.copyWith(
                      fontSize: 24,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Center(
              child: PrimaryButton(
                width: width * 0.5,
                label: data.btnText,
                icon: const Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.black,
                ),
                onPressed: onButtonPressed,
              ),
            ),
            SizedBox(height: height * 0.1),
          ],
        ),
      ],
    );
  }
}

class OnboardingData {
  OnboardingData({
    required this.isFirstPage,
    required this.isLastPage,
    required this.img,
    required this.desc,
    required this.btnText,
  });
  final bool isFirstPage;
  final bool isLastPage;
  final String img;
  final String desc;
  final String btnText;
}
