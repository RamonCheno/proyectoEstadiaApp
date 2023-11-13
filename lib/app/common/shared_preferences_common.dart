import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesCommon {
  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();
  static Future<bool> saveString(String key, String value) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.setString(key, value);
  }

  static Future<String> loadString(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(key)!;
  }

  static Future<void> clearSheadPreferences(String key) async {
    final SharedPreferences prefs = await _prefs;
    prefs.remove(key);
  }
}
