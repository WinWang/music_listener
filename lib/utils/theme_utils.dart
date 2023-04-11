import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music/res/colors.dart';

class Themes {
  static final black = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: ColorStyle.color_333333,
      elevatedButtonTheme:
          ElevatedButtonThemeData(style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.brown))),
      tabBarTheme: TabBarTheme(
        labelColor: ColorStyle.color_white,
        labelStyle: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold),
        unselectedLabelColor: ColorStyle.color_CCCCCC,
        indicatorColor: ColorStyle.color_white,
      ));

  static final red = ThemeData.light().copyWith(
      scaffoldBackgroundColor: Colors.white,
      elevatedButtonTheme:
          ElevatedButtonThemeData(style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.brown))),
      tabBarTheme: TabBarTheme(
        labelColor: ColorStyle.color_white,
        labelStyle: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold),
        unselectedLabelColor: ColorStyle.color_CCCCCC,
        indicatorColor: ColorStyle.color_white,
      ));


}
