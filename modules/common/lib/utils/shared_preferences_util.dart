import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

/// @date on 2021/5/28 15:24
/// @author jack
/// @filename shared_preferences_util.dart
/// @description SharedPreference工具类封装

class SharedPreferenceUtil {
  static Future<bool> putString(String key, String value) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.setString(key, value);
  }

  static Future<String?> getString(String key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(key);
  }

  static Future<bool?> remove(String key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.remove(key);
  }

  static Future<bool?> clear() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.clear();
  }

  static Future<bool?> putBool(String key, bool value) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.setBool(key, value);
  }

  static Future<bool?> getBool(String key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getBool(key);
  }
}
