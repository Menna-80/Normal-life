
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CachHelper {
  static SharedPreferences? pref;

  static init() async
  {
    pref = await SharedPreferences.getInstance();
    await pref?.reload();
  }
  static Future<bool?> putBoolean({
    required String key,
    required bool value,
  }) async
  {
    return await pref?.setBool(key, value);
  }
  static bool? getBoolean({
    required String key,
  })
  {
    return pref?.getBool(key);
  }
  static dynamic getData({
    required String key,

  }) {
    return pref?.get(key);
  }

  static Future<bool?> saveData(
      {required String key, required dynamic value,}) async
  {
    if (value is String) return await pref?.setString(key, value);
    if (value is int) return await pref?.setInt(key, value);
    if (value is bool) return await pref?.setBool(key, value);
    return await pref?.setDouble(key, value);
  }

  static Future<bool?> removeData({
    required String key,
  }) async
  {
    return await pref?.remove(key);
  }




}
