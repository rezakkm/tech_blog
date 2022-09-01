import 'package:flutter/material.dart';

import '../gen/assets.gen.dart';
import '../models/fake_data.dart';
import '../my_colors.dart';
import '../my_component.dart';
import '../my_strings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
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
          // posterHomePage
          PosterHomePage(size: size, textTheme: textTheme),
          const SizedBox(
            height: 20,
          ),
          // list tag
          TagListHomePage(size: size, bodyMargin: bodyMargin),
          const SizedBox(
            height: 28,
          ),
          // view hottest blog
          SeeMoreHottestBlog(bodyMargin: bodyMargin, textTheme: textTheme),
          // blog horizenal list and text
          BlogListHomePage(
              size: size, bodyMargin: bodyMargin, textTheme: textTheme),
          const SizedBox(
            height: 26,
          ),
          // seeMore Hottest PodCasts
          SeeMoreHottestPodcasts(bodyMargin: bodyMargin, textTheme: textTheme),
          PodcastListHomePage(
              size: size, bodyMargin: bodyMargin, textTheme: textTheme),
          // for Ui Bug
          SizedBox(
            height: size.height / 8,
          )
        ],
      ),
    );
  }
}

class PodcastListHomePage extends StatelessWidget {
  const PodcastListHomePage({
    Key? key,
    required this.size,
    required this.bodyMargin,
    required this.textTheme,
  }) : super(key: key);

  final Size size;
  final double bodyMargin;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height / 4.42,
      child: ListView.builder(
          itemCount: 5,
          scrollDirection: Axis.horizontal,
          itemBuilder: ((context, index) {
            return Padding(
              padding:
                  EdgeInsets.fromLTRB(8, 0, index == 0 ? bodyMargin : 8, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: size.width / 3.16,
                    height: size.height / 5.8,
                    decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                  ),
                  Text(
                    'رمزون',
                    style: textTheme.headline4,
                  )
                ],
              ),
            );
          })),
    );
  }
}

class SeeMoreHottestPodcasts extends StatelessWidget {
  const SeeMoreHottestPodcasts({
    Key? key,
    required this.bodyMargin,
    required this.textTheme,
  }) : super(key: key);

  final double bodyMargin;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
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
}

class BlogListHomePage extends StatelessWidget {
  const BlogListHomePage({
    Key? key,
    required this.size,
    required this.bodyMargin,
    required this.textTheme,
  }) : super(key: key);

  final Size size;
  final double bodyMargin;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height / 4.1,
      child: ListView.builder(
          itemCount: blogList.getRange(0, 5).length,
          scrollDirection: Axis.horizontal,
          itemBuilder: ((context, index) {
            // blog horizinal list
            return Padding(
              padding:
                  EdgeInsets.fromLTRB(16, 0, index == 0 ? bodyMargin : 16, 0),
              child: Column(
                children: [
                  // poster blog
                  Stack(
                    children: [
                      Container(
                        width: size.width / 2.4,
                        height: size.height / 5.53,
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16)),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(blogList[index].imageUrl))),
                        foregroundDecoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            gradient: LinearGradient(
                                colors: GradiantColors.blogPoster,
                                begin: Alignment.bottomCenter,
                                end: Alignment.center)),
                      ),
                      Positioned(
                        bottom: 8,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              blogList[index].writer,
                              style: textTheme.bodyText1,
                            ),
                            Row(
                              children: [
                                Text(
                                  blogList[index].views,
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
                    width: size.width / 2.4,
                    child: Text(
                      blogList[index].title,
                      style: textTheme.headline3,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  )
                ],
              ),
            );
          })),
    );
  }
}

class SeeMoreHottestBlog extends StatelessWidget {
  const SeeMoreHottestBlog({
    Key? key,
    required this.bodyMargin,
    required this.textTheme,
  }) : super(key: key);

  final double bodyMargin;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}

class TagListHomePage extends StatelessWidget {
  const TagListHomePage({
    Key? key,
    required this.size,
    required this.bodyMargin,
  }) : super(key: key);

  final Size size;
  final double bodyMargin;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height / 12.7,
      child: ListView.builder(
          itemCount: tagList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: ((context, index) {
            // object tag list
            return Padding(
              padding:
                  EdgeInsets.fromLTRB(8, 8, index == 0 ? bodyMargin : 8, 8),
              child:
                  SimpleOfTagList(size: size, index: index, biuldList: tagList),
            );
          })),
    );
  }
}

class PosterHomePage extends StatelessWidget {
  const PosterHomePage({
    Key? key,
    required this.size,
    required this.textTheme,
  }) : super(key: key);

  final Size size;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: size.height / 4.2,
          width: size.width / 1.18,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              image: DecorationImage(
                  image: AssetImage(homePagePosterMap["imageAsset"]),
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
    );
  }
}
