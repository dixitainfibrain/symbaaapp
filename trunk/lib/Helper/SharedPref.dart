import 'dart:convert';
import 'package:Symbaa/Model/ResponseModel/RegisterModel.dart';
import 'package:Symbaa/Utils/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SharedPref {
  static void remove(String key) async => (await SharedPreferences.getInstance()).remove(key);

  static Future<void> savePreferenceValue(String key, Object value) async {
    final prefs = await SharedPreferences.getInstance();
    print("savePreferenceValue ${value}");
    if (value is String) {
      prefs.setString(key, value);
    } else if (value is int) {
      prefs.setInt(key, value);
    } else if (value is double) {
      prefs.setDouble(key, value);
    } else if (value is bool) {
      prefs.setBool(key, value);
    } else if (value is List<String>) {
      prefs.setStringList(key, value);
    } else {
      prefs.setString(key, json.encode(value));
    }
  }

  static Future<dynamic> readPreference(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final result = prefs.get(key);
    switch (result.runtimeType) {
      case String:
        return result as String;
      case int:
        return result as int;
      case bool:
        return result as bool;
      case List:
        return result as List;
      default:
        return null;
    }
  }

  static Future<dynamic> readPreferenceValue(String key, PrefEnum value) async {
    final prefs = await SharedPreferences.getInstance();
    switch (value) {
      case PrefEnum.STRING:
        return prefs.getString(key) ?? "";
      case PrefEnum.INT:
        return prefs.getInt(key) ?? 0;
      case PrefEnum.DOUBLE:
        return prefs.getDouble(key) ?? 0;
      case PrefEnum.BOOL:
        return prefs.getBool(key) ?? false;
      case PrefEnum.LIST:
        return (prefs.getStringList(key) ?? <String>[]);
      case PrefEnum.MODEL:
        return prefs.getString(key)?.isNotEmpty ?? false ? json.decode(prefs.getString(key)!) : null;
      default:
        break;
    }
  }

  static Future<bool> isLoggedIn() async {
    bool isLoggedIn = await readPreferenceValue(prefKeyIsLogin, PrefEnum.BOOL);
    return isLoggedIn;
  }

  static Future<void> clearSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}

enum PrefEnum { STRING, INT, DOUBLE, BOOL, LIST, MODEL }
