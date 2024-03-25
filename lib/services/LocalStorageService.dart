

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static Future<void> saveData(String key, String jsonData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, jsonData);
  }

  static Future<String?> getData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<void> clearData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
    print("local storage cleared");
  }
  // chauffeur
  // vehicule
}



