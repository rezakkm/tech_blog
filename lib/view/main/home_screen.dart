import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tech_blog/controller/article_list_controller.dart';
import 'package:tech_blog/controller/article_single_controller.dart';
import 'package:tech_blog/controller/home_screen_controller.dart';
import 'package:tech_blog/services/dio_service.dart';
import 'package:tech_blog/view/article_list_screen.dart';

import '../../gen/assets.gen.dart';
import '../../models/fake_data.dart';
import '../../components/my_colors.dart';
import '../../components/my_component.dart';
import '../../components/my_strings.dart';
import '../single_article_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreenController homeScreenController = Get.put(HomeScreenController());
  ArticleListController articleListController =
      Get.put(ArticleListController());
  ArticleSingleController articleSingleController =
      Get.put(ArticleSingleController());

  HomeScreen({
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
    return Obx(
      () => SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: homeScreenController.loading.value == false
              ? Column(
                  children: [
                    // posterHomePage
                    posterHomePage(),
                    const SizedBox(
                      height: 20,
                    ),
                    // list tag
                    tagListHomePage(),
                    const SizedBox(
                      height: 28,
                    ),
                    // view hottest blog
                    seeMoreHottestBlog(),
                    // blog horizenal list and text
                    bloglist(),
                    const SizedBox(
                      height: 26,
                    ),
                    // seeMore Hottest PodCasts
                    seeMoreHottestPodcast(),
                    // podcasts list
                    podcastList(),
                    // for Ui Bug
                    SizedBox(
                      height: size.height / 8,
                    )
                  ],
                )
              : Column(
                  children: [
                    SizedBox(
                      height: size.height / 2.7,
                    ),
                    const SpinKitFadingCube(
                      color: SolidColors.primryColor,
                      size: 32,
                    ),
                  ],
                )),
    );
  }

  Widget seeMoreHottestBlog() {
    return GestureDetector(
      onTap: () {
        Get.to(() => const ArticleListScreen(title: 'لیست مقاله ها'));
      },
      child: Padding(
        padding: EdgeInsets.only(
          bottom: 8,
          right: bodyMargin,
        ),
        child: Row(
          children: [
            ImageIcon(
                Image.asset(
                  Assets.icons.bluePen.path,
                ).image,
                color: SolidColors.seemore),
            const SizedBox(
              width: 6,
            ),
            Text(MyStrings.viewHotestBlog, style: textTheme.subtitle1)
          ],
        ),
      ),
    );
  }

  Widget tagListHomePage() {
    return SizedBox(
      height: size.height / 12.7,
      child: Obx(
        () => ListView.builder(
          itemCount: homeScreenController.tagList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: ((context, index) {
            // object tag list
            return GestureDetector(
              onTap: () {
                String catId = homeScreenController.tagList[index].id;
                articleListController.getArticleListWithTagId(catId);

                String title = homeScreenController.tagList[index].title;
                Get.to(() => ArticleListScreen(title: title));
              },
              child: Padding(
                padding:
                    EdgeInsets.fromLTRB(8, 8, index == 0 ? bodyMargin : 8, 8),
                child: Container(
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
                        ImageIcon(
                          Image.asset(
                            Assets.icons.hashtag.path,
                          ).image,
                          color: Colors.white,
                          size: 12,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(homeScreenController.tagList[index].title,
                            style: textTheme.bodyText1),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget seeMoreHottestPodcast() {
    return Padding(
      padding: EdgeInsets.only(bottom: 8, right: bodyMargin),
      child: Row(
        children: [
          ImageIcon(
            Image.asset(
              Assets.icons.blueMic.path,
            ).image,
            color: SolidColors.seemore,
          ),
          const SizedBox(
            width: 6,
          ),
          Text(
            MyStrings.viewHotestPodasts,
            style: textTheme.subtitle1,
          )
        ],
      ),
    );
  }

// bug Ui while loading
  Widget bloglist() {
    return SizedBox(
        height: size.height / 4.1,
        child: ListView.builder(
            itemCount: homeScreenController.topVisitedList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: ((context, index) {
              // blog horizinal list
              return GestureDetector(
                onTap: () {
                  articleSingleController.getArticleInfo(
                      homeScreenController.topVisitedList[index].id);
                },
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      16, 0, index == 0 ? bodyMargin : 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // poster blog
                      Stack(
                        children: [
                          Container(
                            foregroundDecoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                                gradient: LinearGradient(
                                    colors: GradiantColors.blogPoster,
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.center)),
                            width: size.width / 2.4,
                            height: size.height / 5.53,
                            child: CachedNetworkImage(
                              imageUrl: homeScreenController
                                  .topVisitedList[index].image,
                              imageBuilder: (context, imageProvider) {
                                return Container(
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(16)),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: imageProvider)),
                                );
                              },
                              placeholder: (context, url) =>
                                  const SpinKitFadingCube(
                                color: SolidColors.primryColor,
                                size: 20,
                              ),
                              errorWidget: (context, url, error) => const Icon(
                                Icons.image_not_supported_outlined,
                                color: Colors.grey,
                                size: 40,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 8,
                            left: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  homeScreenController
                                      .topVisitedList[index].author,
                                  style: textTheme.bodyText1,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      homeScreenController
                                          .topVisitedList[index].view,
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
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      // title blog
                      SizedBox(
                        width: size.width / 3,
                        child: Text(
                          homeScreenController.topVisitedList[index].title,
                          style: textTheme.headline3,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      )
                    ],
                  ),
                ),
              );
            })));
  }

  Widget podcastList() {
    return SizedBox(
      height: size.height / 4.42,
      child: Obx(
        () => ListView.builder(
            itemCount: homeScreenController.topPodcasts.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: ((context, index) {
              return Padding(
                padding:
                    EdgeInsets.fromLTRB(8, 0, index == 0 ? bodyMargin : 8, 0),
                child: SizedBox(
                  width: size.height / 4.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: size.width / 3.16,
                        height: size.height / 5.8,
                        child: CachedNetworkImage(
                          imageUrl:
                              homeScreenController.topPodcasts[index].poster,
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(16)),
                                  image: DecorationImage(
                                      fit: BoxFit.cover, image: imageProvider)),
                            );
                          },
                          placeholder: (context, url) =>
                              const SpinKitFadingCube(
                            color: SolidColors.primryColor,
                            size: 20,
                          ),
                          errorWidget: (context, url, error) => const Icon(
                            Icons.image_not_supported_outlined,
                            color: Colors.grey,
                            size: 40,
                          ),
                        ),
                      ),
                      Text(
                        homeScreenController.topPodcasts[index].title,
                        style: textTheme.headline4,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      )
                    ],
                  ),
                ),
              );
            })),
      ),
    );
  }

  Widget posterHomePage() {
    return Stack(
      children: [
        Container(
          height: size.height / 4.2,
          width: size.width / 1.18,
          foregroundDecoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              gradient: LinearGradient(
                  colors: GradiantColors.homeCoverPosterGradient,
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter)),
          child: CachedNetworkImage(
            imageUrl: homeScreenController.poster.value.image,
            imageBuilder: (context, imageProvider) {
              return Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    image: DecorationImage(
                        fit: BoxFit.cover, image: imageProvider)),
              );
            },
            placeholder: (context, url) => const SpinKitFadingCube(
              color: SolidColors.primryColor,
              size: 20,
            ),
            errorWidget: (context, url, error) => const Icon(
              Icons.image_not_supported_outlined,
              color: Colors.grey,
              size: 40,
            ),
          ),
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
                homeScreenController.poster.value.title,
                style: textTheme.headline1,
              )
            ],
          ),
        )
      ],
    );
  }
}
