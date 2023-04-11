import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music/utils/theme_utils.dart';

class ThemeController extends GetxController {
  var isDarkMode = false.obs;

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
  }

  ThemeData get themeData => isDarkMode.value ? Themes.black : Themes.red;

}
