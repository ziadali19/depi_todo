import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeServices {
  final GetStorage box = GetStorage();
  final key = 'isDarkMode';

  saveToBox(bool isDarkMode) {
    box.write(key, isDarkMode);
  }

  loadFromBox() {
    return box.read<bool>(key) ?? false;
  }

  get theme {
    return loadFromBox() ? ThemeMode.dark : ThemeMode.light;
  }

  switchTheme() {
    Get.changeThemeMode(loadFromBox() ? ThemeMode.light : ThemeMode.dark);
    saveToBox(!loadFromBox());
  }
}
