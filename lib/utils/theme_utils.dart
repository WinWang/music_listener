import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music/res/colors.dart';

class Themes {
  static final black = ThemeData.light().copyWith(
      scaffoldBackgroundColor: Colors.black,
      // appBarTheme: AppBarTheme(
      //     backgroundColor: Colors.black,
      //     textTheme: TextTheme(
      //         headline6: TextStyle(color: Colors.white, fontSize: 30.sp))),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.brown))));

  static final red = ThemeData.light().copyWith(
      scaffoldBackgroundColor: ColorStyle.color_EA4C43,
      // appBarTheme: AppBarTheme(
      //     backgroundColor: ColorStyle.color_EA4C43,
      //     textTheme: TextTheme(
      //         headline6: TextStyle(color: Colors.black, fontSize: 30.sp))),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.brown))));
}
