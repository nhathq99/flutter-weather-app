import 'dart:convert';

import 'package:flutter_weather_app/constants/shared_prefs_constants.dart';
import 'package:flutter_weather_app/utils/preference_connector.dart';

class StorageUtil {
  static Future<List<String>> getSavedLocations() async {
    final jsonData = await PreferenceConnector()
        .getString(SharedPrefsConstants.savedLocations);
    if (jsonData.isEmpty) return [];
    return List.from(json.decode(jsonData) as List<dynamic>);
  }

  static void storeLocations(List<String> locations) {
    final jsonString = json.encode(locations);
    PreferenceConnector().setString(
      SharedPrefsConstants.savedLocations,
      jsonString,
    );
  }

  static Future<bool> isFirstLaunch() async {
    return PreferenceConnector().getBool(SharedPrefsConstants.firstLaunch);
  }

  static void storeFirstLaunch(bool launched) {
    PreferenceConnector().setBool(
      SharedPrefsConstants.firstLaunch,
      launched,
    );
  }

  static Future<bool> isHideOnboarding() async {
    return PreferenceConnector().getBool(SharedPrefsConstants.hideOnboarding);
  }

  static void storeOnboarding(bool isHide) {
    PreferenceConnector().setBool(
      SharedPrefsConstants.hideOnboarding,
      isHide,
    );
  }

  static Future<String> getCurrentLang() async {
    return PreferenceConnector()
        .getString(SharedPrefsConstants.currentLanguage);
  }

  static Future<String> storeCurrentLang(String lang) async {
    return PreferenceConnector()
        .getString(SharedPrefsConstants.currentLanguage);
  }

  static Future<bool> remove(String key) {
    return PreferenceConnector().removePreference(key);
  }

  static Future<void> removeSecure(String key) {
    return PreferenceConnector().removeSecure(key);
  }

  static Future<void> deleteAllSecure() {
    return PreferenceConnector().clearSecure();
  }

  static Future<bool> deleteAll() {
    return PreferenceConnector().clear();
  }
}
