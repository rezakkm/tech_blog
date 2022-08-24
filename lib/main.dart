import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tech_blog/my_colors.dart';
import 'package:tech_blog/splash_screen.dart';
import 'package:tech_blog/gen/assets.gen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: solidColors.statusBar,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: solidColors.navigationBar,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('fa', ''), // persian, no country code
        ],
        title: 'Flutter Demo',
        theme: ThemeData(
            fontFamily: 'dana',
            textTheme: const TextTheme(
              headline1: TextStyle(
                  fontFamily: 'dana',
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
              headline2: TextStyle(
                  fontFamily: 'dana',
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
              bodyText1: TextStyle(
                  fontFamily: 'dana',
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w300),
              bodyText2: TextStyle(
                  fontFamily: 'dana',
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w300),
            )),
        debugShowCheckedModeBanner: false,
        home: SplashScreen());
  }
}
