import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tech_blog/components/my_strings.dart';
import 'package:tech_blog/controller/register_controller.dart';

import 'package:tech_blog/gen/assets.gen.dart';

import 'package:tech_blog/components/my_colors.dart';
import 'package:tech_blog/components/my_component.dart';

import 'package:tech_blog/view/main/home_screen.dart';
import 'package:tech_blog/view/main/profile_screen.dart';
import 'package:tech_blog/view/main/signIn/rigester_intro.dart';

final GlobalKey<ScaffoldState> _key = GlobalKey();

class MainScreen extends StatelessWidget {
  RxInt selectedPageIndex = 0.obs;

  MainScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    var bodyMargin = size.width / 12;

    return SafeArea(
      child: Scaffold(
        key: _key,
        drawer: Drawer(
            backgroundColor: SolidColors.scafoldBg,
            child: ListView(
              children: [
                DrawerHeader(
                    child: Image.asset(
                  Assets.images.logo.path,
                  scale: 2.5,
                )),
                TechDivider(bodyMargin: bodyMargin / 2),
                ListTile(
                  title: Padding(
                    padding: EdgeInsets.only(right: bodyMargin / 2),
                    child: Text(
                      'پروفایل کابری',
                      style: textTheme.headline6,
                    ),
                  ),
                  onTap: () {},
                ),
                TechDivider(bodyMargin: bodyMargin / 2),
                ListTile(
                  title: Padding(
                    padding: EdgeInsets.only(right: bodyMargin / 2),
                    child: Text(
                      'درباره تک بلاگ',
                      style: textTheme.headline6,
                    ),
                  ),
                  onTap: () {},
                ),
                TechDivider(bodyMargin: bodyMargin / 2),
                ListTile(
                  title: Padding(
                    padding: EdgeInsets.only(right: bodyMargin / 2),
                    child: Text(
                      'اشتراک گذاری تک بلاگ',
                      style: textTheme.headline6,
                    ),
                  ),
                  onTap: () async {
                    await Share.share(MyStrings.shareTechBlog);
                  },
                ),
                TechDivider(bodyMargin: bodyMargin / 2),
                ListTile(
                  title: Padding(
                    padding: EdgeInsets.only(right: bodyMargin / 2),
                    child: Text(
                      'تک بلاگ در گیت هاب',
                      style: textTheme.headline6,
                    ),
                  ),
                  onTap: () {
                    myUrlLauncher(MyStrings.launchGithubUrl);
                  },
                ),
              ],
            )),
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: SolidColors.scafoldBg,
          title: Padding(
            padding: EdgeInsets.fromLTRB(bodyMargin / 4, 0, bodyMargin / 4, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    _key.currentState!.openDrawer();
                  },
                  child: const Icon(
                    Icons.menu,
                    color: Colors.black,
                  ),
                ),
                Image(
                  image: Image.asset(Assets.images.logo.path).image,
                  height: size.height / 13.63,
                ),
                const Icon(
                  Icons.search,
                  color: Colors.black,
                )
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            // body
            Positioned.fill(child: Obx(() {
              return IndexedStack(
                index: selectedPageIndex.value,
                children: [
                  HomeScreen(
                      size: size, textTheme: textTheme, bodyMargin: bodyMargin),
                  ProfileScreen(
                      size: size, textTheme: textTheme, bodyMargin: bodyMargin),
                ],
              );
            })),
            // navigation Bar
            NavigationBar(
                size: size,
                changeScreen: (int value) {
                  selectedPageIndex.value = value;
                }),
          ],
        ),
      ),
    );
  }
}

class NavigationBar extends StatelessWidget {
  NavigationBar({
    Key? key,
    required this.size,
    required this.changeScreen,
  }) : super(key: key);

  final Size size;
  final Function(int) changeScreen;
  RegisterController registerController = Get.put(RegisterController());
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: size.height / 5.9,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: GradiantColors.backgroundBottomNav,
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter)),
        // navigation box button
        child: Stack(
          children: [
            Positioned(
              bottom: size.height / 40,
              right: size.width / 2 - size.width / 2.74,
              child: Container(
                width: size.width / 1.37,
                height: size.height / 12.35,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    gradient: LinearGradient(colors: GradiantColors.bottomNav)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed: () {
                          changeScreen(0);
                        },
                        icon: ImageIcon(
                          Image.asset(
                            Assets.icons.icon.path,
                          ).image,
                          color: Colors.white,
                        )),
                    Obx(
                      () => IconButton(
                          onPressed: () {
                            registerController.checkLogIn();
                          },
                          icon: ImageIcon(
                            Image.asset(
                              Assets.icons.write.path,
                            ).image,
                            color: Colors.white,
                          )),
                    ),
                    IconButton(
                        onPressed: () {
                          changeScreen(1);
                        },
                        icon: ImageIcon(
                          Image.asset(
                            Assets.icons.user.path,
                          ).image,
                          color: Colors.white,
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
