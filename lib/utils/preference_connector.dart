import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceConnector {
  Future<SharedPreferences> _getSharedPreference() async {
    return SharedPreferences.getInstance();
  }

  FlutterSecureStorage _getSecureStored() {
    return const FlutterSecureStorage();
  }

  Future<String> getString(String key) async {
    final prefs = await _getSharedPreference();
    return prefs.getString(key) ?? '';
  }

  Future<int> getInt(String key) async {
    final prefs = await _getSharedPreference();
    return prefs.getInt(key) ?? -1;
  }

  Future<double> getDouble(String key) async {
    final prefs = await _getSharedPreference();
    return prefs.getDouble(key) ?? -1;
  }

  Future<bool> getBool(String key) async {
    final prefs = await _getSharedPreference();
    return prefs.getBool(key) ?? false;
  }

  Future<void> setString(String key, String value) async {
    final prefs = await _getSharedPreference();
    await prefs.setString(key, value);
  }

  Future<void> setInt(String key, int value) async {
    final prefs = await _getSharedPreference();
    await prefs.setInt(key, value);
  }

  Future<void> setDouble(String key, double value) async {
    final prefs = await _getSharedPreference();
    await prefs.setDouble(key, value);
  }

  Future<void> setBool(String key, bool value) async {
    final prefs = await _getSharedPreference();
    await prefs.setBool(key, value);
  }

  Future<bool> removePreference(String key) async {
    final prefs = await _getSharedPreference();
    return prefs.remove(key);
  }

  Future<bool> clear() async {
    final prefs = await _getSharedPreference();
    return prefs.clear();
  }

  Future<String> getSecure(String key) async {
    final val = await _getSecureStored().read(key: key);
    return val ?? '';
  }

  Future<void> setSecure(String key, String value) async {
    await _getSecureStored().write(key: key, value: value);
  }

  Future<void> removeSecure(String key) async {
    return _getSecureStored().delete(key: key);
  }

  Future<void> clearSecure() async {
    return _getSecureStored().deleteAll();
  }
}
