import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:tech_blog/components/my_colors.dart';

import 'package:tech_blog/view/main/main_screen.dart';

import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: SolidColors.statusBar,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: SolidColors.navigationBar,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        locale: const Locale('fa'),
        title: 'Flutter Demo',
        theme: ThemeData(
          inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                borderSide: BorderSide(width: 1.5)),
          ),
          fontFamily: 'dana',
          textTheme: const TextTheme(
            headline1: TextStyle(
                fontFamily: 'dana',
                fontSize: 15,
                color: SolidColors.textTitleHomePoster,
                fontWeight: FontWeight.w700),
            headline2: TextStyle(
                fontFamily: 'dana',
                fontSize: 14,
                color: SolidColors.textSUbitleHomePoster,
                fontWeight: FontWeight.w700),
            headline5: TextStyle(
                fontFamily: 'dana',
                fontSize: 14,
                color: SolidColors.primryColor,
                fontWeight: FontWeight.w700),
            headline3: TextStyle(
                fontFamily: 'dana',
                fontSize: 12,
                color: SolidColors.textTitle,
                fontWeight: FontWeight.w700),
            bodyText1: TextStyle(
                fontFamily: 'dana',
                fontSize: 14,
                color: SolidColors.textSUbitleHomePoster,
                fontWeight: FontWeight.w300),
            bodyText2: TextStyle(
                fontFamily: 'dana',
                fontSize: 14,
                color: SolidColors.hashtagText,
                fontWeight: FontWeight.w300),
            subtitle1: TextStyle(
                fontFamily: 'dana',
                fontSize: 12,
                color: SolidColors.seemore,
                fontWeight: FontWeight.w300),
            headline4: TextStyle(
                fontFamily: 'dana',
                fontSize: 15,
                color: SolidColors.textTitle,
                fontWeight: FontWeight.w700),
            headline6: TextStyle(
                fontFamily: 'dana',
                fontSize: 13,
                color: SolidColors.textTitle,
                fontWeight: FontWeight.w700),
            subtitle2: TextStyle(
                fontFamily: 'dana',
                fontSize: 14,
                color: SolidColors.welcomeText,
                fontWeight: FontWeight.w700),
            overline: TextStyle(
                fontFamily: 'dana',
                fontSize: 12,
                color: SolidColors.textTitle,
                fontWeight: FontWeight.w300),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
            animationDuration: const Duration(milliseconds: 100),
            backgroundColor: MaterialStateProperty.resolveWith(((states) {
              if (states.contains(MaterialState.pressed)) {
                return SolidColors.seemore;
              }
              return SolidColors.primryColor;
            })),
          )),
        ),
        debugShowCheckedModeBanner: false,
        home: MainScreen());
  }
}
