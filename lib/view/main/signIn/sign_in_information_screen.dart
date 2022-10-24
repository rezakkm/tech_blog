import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:tech_blog/models/fake_data.dart';
import 'package:tech_blog/components/my_component.dart';
import 'package:tech_blog/components/my_strings.dart';
import '../../../controller/home_screen_controller.dart';
import '../../../gen/assets.gen.dart';

class SignInInfo extends StatefulWidget {
  const SignInInfo({Key? key}) : super(key: key);

  @override
  State<SignInInfo> createState() => _SignInInfoState();
}

class _SignInInfoState extends State<SignInInfo> {
  HomeScreenController homeScreenController = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var texttheme = Theme.of(context).textTheme;
    var bodyMargin = size.width / 10;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: size.height / 10,
              ),
              SvgPicture.asset(Assets.icons.techBot.path,
                  height: size.height / 6),
              SizedBox(
                height: size.height / 30,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: MyStrings.signInText, style: texttheme.subtitle2),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(bodyMargin, 24, bodyMargin, 20),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: "نام و نام خانوادگی",
                    hintStyle:
                        TextStyle(color: Color.fromARGB(255, 200, 200, 200)),
                  ),
                ),
              ),
              Text(MyStrings.chooseCategory, style: texttheme.headline5),
              Padding(
                padding: EdgeInsets.only(top: size.height / 40),
                child: SizedBox(
                  width: double.maxFinite,
                  height: size.height / 6,
                  child: GridView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: tagList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.4,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 7,
                      ),
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: InkWell(
                              onTap: () {
                                setState(() {
                                  if (favTagList.contains(homeScreenController
                                          .tagList[index]) ==
                                      false) {
                                    favTagList.add(
                                        homeScreenController.tagList[index]);
                                  }
                                });
                              },
                              child: SimpleOfTagList(
                                size: size,
                                index: index,
                              )),
                        );
                      })),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset(
                  Assets.icons.downarrow.path,
                  scale: 2.5,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: size.height / 40),
                child: SizedBox(
                  width: double.maxFinite,
                  height: size.height / 6,
                  child: GridView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: favTagList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.33,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 7,
                      ),
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: InkWell(
                              onTap: () {
                                setState(() {
                                  favTagList.remove(favTagList[index]);
                                });
                              },
                              child: SimpleOfFavTag(
                                size: size,
                                index: index,
                                biuldList: favTagList,
                              )),
                        );
                      })),
                ),
              ),
              SizedBox(
                height: size.height / 12,
              ),
              ButtonTheme(
                minWidth: size.width / 2.5,
                height: size.height / 15,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size.fromWidth(size.width / 3)),
                    onPressed: () {},
                    child: const Text(
                      '   ادامه   ',
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
