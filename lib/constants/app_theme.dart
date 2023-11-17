import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_weather_app/constants/app_colors.dart';

class AppTheme {
  static ThemeData get appTheme {
    return ThemeData(
      useMaterial3: true,
      primaryColor: AppColors.primaryColor,
      hintColor: AppColors.silver,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.primaryColor,
        selectionColor: AppColors.primaryColor,
        selectionHandleColor: AppColors.primaryColor,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.primaryColor,
          ),
        ),
      ),
      scaffoldBackgroundColor: AppColors.blueChalk,
      textTheme: GoogleFonts.nunitoTextTheme(
        const TextTheme(
          displayLarge: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
          bodyLarge: TextStyle(
            color: Colors.black,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
          bodyMedium: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
          labelLarge: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  static TextStyle get headerTextStyle => appTheme.textTheme.displayLarge!;

  static TextStyle get titleTextStyle => appTheme.textTheme.bodyLarge!;

  static TextStyle get bodyTextStyle => appTheme.textTheme.bodyMedium!;

  static TextStyle get buttonTextStyle => appTheme.textTheme.labelLarge!;
}
