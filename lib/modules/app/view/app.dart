import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_weather_app/config/app_config.dart';
import 'package:flutter_weather_app/constants/app_theme.dart';
import 'package:flutter_weather_app/l10n/l10n.dart';
import 'package:flutter_weather_app/utils/routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      // Close keyboard when tap outside input zone (textField,...)
      onTap: () => WidgetsBinding.instance.focusManager.primaryFocus?.unfocus(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppConfig.instance.flavor.name,
        theme: AppTheme.appTheme,
        supportedLocales: AppLocalizations.supportedLocales,
        initialRoute: Routes.splashPage,
        onGenerateRoute: Routes.generateRoutes,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        builder: (ctx, child) {
          return MediaQuery(
            data: MediaQuery.of(ctx).copyWith(
              textScaleFactor: 1,
              boldText: false,
            ),
            child: child!,
          );
        },
      ),
    );
  }
}
