import 'package:flutter/material.dart';

const Color bluishClr = Color.fromARGB(255, 62, 67, 126);
const Color orangeClr = Color(0xCFFF8746);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const primaryClr = bluishClr;
const Color darkGreyClr = Color.fromARGB(255, 34, 34, 34);
const Color darkHeaderClr = Color(0xFF424242);

class Themes {
  static ThemeData light = ThemeData(
      appBarTheme: const AppBarTheme(color: Color.fromARGB(255, 246, 243, 243)),
      fontFamily: 'AeonicTRIAL',
      scaffoldBackgroundColor: const Color.fromARGB(255, 246, 243, 243),
      primaryColor: Colors.teal[600],
      brightness: Brightness.light);
  static ThemeData dark = ThemeData(
      scaffoldBackgroundColor: darkGreyClr,
      appBarTheme: const AppBarTheme(color: darkGreyClr),
      fontFamily: 'AeonicTRIAL',
      primaryColor: darkGreyClr,
      brightness: Brightness.dark);
}
