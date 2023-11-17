import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_app/modules/home/home.dart';
import 'package:flutter_weather_app/modules/onboarding/onboarding.dart';
import 'package:flutter_weather_app/modules/splash/splash.dart';
import 'package:flutter_weather_app/modules/weather_detail/view/weather_detail_page.dart';

class Routes {
  static const splashPage = '/';
  static const onboardingPage = '/onboarding_page';
  static const homePage = '/home_page';
  static const weatherDetailPage = '/weather_detail_page';

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case splashPage:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => const SplashPage(),
        );
      case onboardingPage:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => const OnBoardingPage(),
        );
      case homePage:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => const HomePage(),
        );
      case weatherDetailPage:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => const WeatherDetailPage(),
        );
      default:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => Scaffold(
            body: Center(
              child: Text(
                'No route defined for ${settings.name}',
              ),
            ),
          ),
        );
    }
  }
}
