import 'package:flutter/material.dart';
import 'package:tech_blog/components/my_component.dart';
import 'package:tech_blog/gen/assets.gen.dart';

import 'package:tech_blog/view/main/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MainScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: Image.asset(
                  Assets.images.logo.path,
                ).image,
                height: 64,
              ),
              const SizedBox(
                height: 32,
              ),
              loading(),
            ],
          ),
        ),
      ),
    );
  }
}
