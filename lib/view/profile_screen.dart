import 'package:flutter/material.dart';

import '../gen/assets.gen.dart';

import '../my_colors.dart';
import '../my_component.dart';
import '../my_strings.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    Key? key,
    required this.size,
    required this.textTheme,
    required this.bodyMargin,
  }) : super(key: key);

  final Size size;
  final TextTheme textTheme;
  final double bodyMargin;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: size.height / 15,
            ),
            // profile Image
            Image(
              image: AssetImage(Assets.icons.profileAvatar.path),
              width: size.width / 3.76,
            ),
            // edit profile
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageIcon(
                    Image.asset(
                      Assets.icons.bluePen.path,
                    ).image,
                    color: SolidColors.seemore,
                    size: 18,
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Text(MyStrings.editPrifile, style: textTheme.subtitle1)
                ],
              ),
            ),

            SizedBox(
              height: size.height / 20,
            ),
            // user name
            Text(
              'فاطمه امیری',
              style: textTheme.headline5,
            ),
            SizedBox(
              height: size.height / 100,
            ),
            //  user Email
            Text(
              'fatemeamiri@gmail.com',
              style: textTheme.headline6,
            ),
            SizedBox(height: size.height / 25),
            //  favatite blog
            TechDivider(bodyMargin: bodyMargin),
            InkWell(
              onTap: () {},
              splashColor: SolidColors.primryColor,
              child: SizedBox(
                height: size.height / 20,
                width: double.maxFinite,
                child: Center(
                  child: Text(
                    MyStrings.favariteBlog,
                    style: textTheme.headline6,
                  ),
                ),
              ),
            ),

            TechDivider(bodyMargin: bodyMargin),
            // favarite podcast
            InkWell(
              onTap: () {},
              splashColor: SolidColors.primryColor,
              child: SizedBox(
                height: size.height / 20,
                width: double.maxFinite,
                child: Center(
                  child: Text(
                    MyStrings.favaritePodcast,
                    style: textTheme.headline6,
                  ),
                ),
              ),
            ),
            // exit profile
            TechDivider(bodyMargin: bodyMargin),

            InkWell(
              onTap: () {},
              splashColor: SolidColors.primryColor,
              child: SizedBox(
                height: size.height / 20,
                width: double.maxFinite,
                child: Center(
                  child: Text(
                    MyStrings.exitPrifile,
                    style: textTheme.headline6,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
