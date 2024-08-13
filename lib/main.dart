// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo/db/db_helper.dart';
import 'package:todo/ui/theme.dart';

import 'ui/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDb();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        theme: Themes.light,
        darkTheme: Themes.dark,
        themeMode: ThemeMode.dark /*ThemeServices().theme,*/,
        debugShowCheckedModeBanner: false,
        home:
            const HomePage() /*NotificationScreen(
        payload: 'Ziad|ali|3:47',
      ),*/
        );
  }
}

Text MyTextStyle(String str, double FS) {
  return Text(
    str,
    style: TextStyle(
        fontSize: FS,
        fontWeight: FontWeight.bold,
        color: Get.isDarkMode ? Colors.white : darkGreyClr),
  );
}

Text MyTextStyle1(String str, double FS) {
  return Text(
    str,
    style: TextStyle(
        fontSize: FS,
        fontWeight: FontWeight.w500,
        color: Get.isDarkMode ? Colors.white : darkGreyClr),
  );
}

Text MyTextStyle2(String str, double FS) {
  return Text(
    str,
    textAlign: TextAlign.justify,
    style: TextStyle(
        fontSize: FS,
        fontWeight: FontWeight.bold,
        color: Get.isDarkMode ? Colors.white : darkGreyClr),
  );
}

Text MyTextStyle3(String str, double FS) {
  return Text(
    str,
    textAlign: TextAlign.center,
    style: TextStyle(
        fontSize: FS,
        fontWeight: FontWeight.bold,
        color: Get.isDarkMode ? Colors.white : darkGreyClr),
  );
}

Text MyTextStyle4(String str, double FS) {
  return Text(
    str,
    textAlign: TextAlign.left,
    style: TextStyle(
        fontSize: FS,
        fontWeight: FontWeight.bold,
        color: Get.isDarkMode ? Colors.white : darkGreyClr),
  );
}

Text MyTextStyle5(String str, double FS) {
  return Text(
    str,
    style: TextStyle(
        fontSize: FS, fontWeight: FontWeight.bold, color: Colors.white),
  );
}

Text MyTextStyle6(String str, double FS) {
  return Text(
    str,
    style: TextStyle(
        fontSize: FS, fontWeight: FontWeight.w500, color: Colors.white),
  );
}

Text MyTextStyle7(String str, double FS) {
  return Text(
    str,

    //textAlign: TextAlign.end,
    style: TextStyle(
        textBaseline: TextBaseline.alphabetic,
        fontSize: FS,
        fontWeight: FontWeight.w500,
        color: Colors.white),
  );
}

Text MyTextStyle8(String str, double FS) {
  return Text(
    str,
    style: TextStyle(
        fontSize: FS, fontWeight: FontWeight.bold, color: Colors.white),
  );
}
