import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tech_blog/components/my_text_style.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controller/home_screen_controller.dart';
import '../gen/assets.gen.dart';

import 'my_colors.dart';

class TechDivider extends StatelessWidget {
  const TechDivider({
    Key? key,
    required this.bodyMargin,
  }) : super(key: key);

  final double bodyMargin;

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: SolidColors.dividerColor,
      thickness: 0.5,
      indent: bodyMargin * 2,
      endIndent: bodyMargin * 2,
    );
  }
}

// ignore: must_be_immutable
class SimpleOfTagList extends StatelessWidget {
  HomeScreenController homeScreenController = Get.put(HomeScreenController());
  SimpleOfTagList({
    Key? key,
    required this.size,
    required this.index,
  }) : super(key: key);

  final Size size;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height / 12.7,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          gradient: LinearGradient(
              colors: GradiantColors.hashtags,
              begin: Alignment.centerRight,
              end: Alignment.centerLeft)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
        child: Row(
          children: [
            const SizedBox(
              width: 5,
            ),
            ImageIcon(
              Image.asset(
                Assets.icons.hashtag.path,
              ).image,
              color: Colors.white,
              size: 12,
            ),
            const SizedBox(
              width: 6,
            ),
            Obx(() => Text(
                  homeScreenController.tagList[index].title,
                  style: tagFont,
                ))
          ],
        ),
      ),
    );
  }
}

class SimpleOfFavTag extends StatelessWidget {
  const SimpleOfFavTag(
      {Key? key,
      required this.size,
      required this.index,
      required this.biuldList})
      : super(key: key);

  final Size size;
  final int index;
  final List biuldList;

  @override
  Widget build(BuildContext context) {
    var texttheme = Theme.of(context).textTheme;
    return Container(
      height: size.height / 12.7,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Color.fromARGB(255, 230, 230, 230)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox.shrink(),
            Text(
              biuldList[index].title,
              style: texttheme.headline3,
            ),
            const Icon(
              Icons.remove_sharp,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}

myUrlLauncher(String url) async {
  var uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    launchUrl(uri);
  }
  log('could not launch ${uri.toString()}');
}

AppBar primryAppBar(String title) {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
    actions: [
      Padding(
        padding: const EdgeInsets.only(left: 32, top: 20),
        child: Text(
          title,
          style: appBarText,
        ),
      )
    ],
    leading: Padding(
      padding: const EdgeInsets.only(right: 16),
      child: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              color: SolidColors.primryColor.withAlpha(180),
              shape: BoxShape.circle),
          child: const Icon(Icons.arrow_back_ios_rounded),
        ),
      ),
    ),
  );
}

Widget loading() {
  return const SpinKitFadingCube(
    color: SolidColors.primryColor,
    size: 32,
  );
}
