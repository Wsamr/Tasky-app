import 'package:shared_preferences/shared_preferences.dart';

abstract class AppSharedPref {
  static late SharedPreferences prefs;
  static initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<void> saveData(String key, dynamic value) async {
    if (value is String) {
      await prefs.setString(key, value);
    } else if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    } else if (value is bool) {
      await prefs.setBool(key, value);
    } else {
      print("not Supported");
    }
  }

  static Future<Object?> getData(String key) async {
    return prefs.get(key);
  }

  static Future<void> removeData(String key) async {
    prefs.remove(key);
  }
}
