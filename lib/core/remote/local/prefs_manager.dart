import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsManager {
  static late SharedPreferences prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static void saveTheme(ThemeMode mode) {
    if (mode == ThemeMode.dark) {
      prefs.setString("theme", "dark");
    } else {
      prefs.setString("theme", "light");
    }
  }

  static ThemeMode getTheme() {
    String theme = prefs.getString("theme") ?? "light";
    if (theme == "dark") {
      return ThemeMode.dark;
    } else {
      return ThemeMode.light;
    }
  }
  static void startScreenBuild(bool isBuilt) {
    prefs.setBool("buildOnboarding", isBuilt);
  }

  static bool getStartScreenBuild() {
    return prefs.getBool("buildOnboarding")??false;
  }
}
