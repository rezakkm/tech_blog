import 'package:flutter/material.dart';
import 'package:tech_blog/gen/assets.gen.dart';
import 'package:tech_blog/models/fake_data.dart';

import 'components/my_colors.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    var bodyMargin = size.width / 10;
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
            child: Column(
              children: [
                //  appBar
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      bodyMargin - 10, 0, bodyMargin - 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.menu),
                      Image(
                        image: Image.asset(Assets.images.logo.path).image,
                        height: size.height / 13.63,
                      ),
                      Icon(Icons.search)
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                // posterHomePage
                Stack(
                  children: [
                    Container(
                      height: size.height / 4.2,
                      width: size.width / 1.24,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                          image: DecorationImage(
                              image:
                                  AssetImage(homePagePosterMap["imageAsset"]),
                              fit: BoxFit.cover)),
                      foregroundDecoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          gradient: LinearGradient(
                              colors: GradiantColors.homeCoverPosterGradient,
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter)),
                    ),
                    Positioned(
                      bottom: 8,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                homePagePosterMap["writer"] +
                                    ' - ' +
                                    homePagePosterMap['date'],
                                style: textTheme.bodyText1,
                              ),
                              Row(
                                children: [
                                  Text(
                                    homePagePosterMap['view'],
                                    style: textTheme.bodyText1,
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  const Icon(
                                    Icons.remove_red_eye,
                                    size: 16,
                                    color: Colors.white,
                                  )
                                ],
                              )
                            ],
                          ),
                          Text(
                            'دوازده قدم برنامه نویسی یک دوره ی...س',
                            style: textTheme.headline1,
                          )
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                // list tag
                SizedBox(
                  height: size.height / 12.7,
                  child: ListView.builder(
                      itemCount: tagList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: ((context, index) {
                        // object tag list
                        return Padding(
                          padding: EdgeInsets.fromLTRB(
                              8, 8, index == 0 ? bodyMargin : 8, 8),
                          child: Container(
                            height: size.height / 12.7,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                                gradient: LinearGradient(
                                    colors: GradiantColors.hashtags,
                                    begin: Alignment.centerRight,
                                    end: Alignment.centerLeft)),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                              child: Row(
                                children: [
                                  Text(
                                    '#',
                                    style: textTheme.headline1,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(tagList[index].title)
                                ],
                              ),
                            ),
                          ),
                        );
                      })),
                ),

                Row(
                  children: [
                    // ImageIcon(Assets),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
