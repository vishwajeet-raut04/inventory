// TODO Implement this library.import 'dart:convert';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static SharedPreferences? _prefs;

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future saveData(String key, dynamic value) async {
    _prefs!.setString(key, jsonEncode(value));
  }

  static dynamic readData(String key) {
    final data = _prefs!.getString(key);
    return data == null ? null : jsonDecode(data);
  }

  static Future clearAll() async {
    await _prefs!.clear();
  }
}
