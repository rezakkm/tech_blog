import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

import 'package:share_plus/share_plus.dart';
import 'package:tech_blog/components/my_colors.dart';

import 'package:tech_blog/components/my_text_style.dart';
import 'package:tech_blog/controller/article/article_list_controller.dart';
import 'package:tech_blog/controller/article/article_single_controller.dart';
import 'package:tech_blog/gen/assets.gen.dart';

import 'package:tech_blog/view/article/article_list_screen.dart';

import '../../components/my_component.dart';

class ArticleSingleScreen extends StatelessWidget {
  ArticleSingleController articleSingleController =
      Get.put(ArticleSingleController());
  ArticleListController articleListController =
      Get.put(ArticleListController());

  ArticleSingleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var texttheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
          body: Obx(
        () => SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: articleSingleController.loading.value == true
              ? Column(
                  children: [
                    SizedBox(
                      height: size.height / 2.7,
                    ),
                    const SpinKitFadingCube(
                      color: SolidColors.primryColor,
                      size: 32,
                    ),
                  ],
                )
              : Column(
                  children: [
                    // poster
                    Poster(
                        size: size,
                        articleSingleController: articleSingleController),
                    // titleArticle
                    SizedBox(
                      width: double.infinity,
                      height: size.height / 12,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 20, top: 10, right: 10),
                        child: Text(
                          articleSingleController.articleInfo.value.title,
                          overflow: TextOverflow.ellipsis,
                          style: titleArticleSingleScreen,
                          maxLines: 2,
                        ),
                      ),
                    ),
                    // auther information
                    SizedBox(
                      height: size.height / 20,
                      child: Row(children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: size.width / 10,
                          height: size.width / 10,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: Image.asset(
                                          Assets.icons.profileAvatar.path)
                                      .image),
                              shape: BoxShape.circle),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          articleSingleController.articleInfo.value.author,
                          style: texttheme.overline,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          articleSingleController.articleInfo.value.createdAt,
                          style: dateSubmitArticle,
                        )
                      ]),
                    ),
                    // text of article
                    SizedBox(
                      height: size.height / 40,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 30, right: 20),
                        child: HtmlWidget(
                          textStyle: articleTextFont,
                          articleSingleController.articleInfo.value.content,
                          enableCaching: true,
                          onLoadingBuilder:
                              ((context, element, loadingProgress) =>
                                  loading()),
                        )),
                    // cats names
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 15, 10, 15),
                      child: SizedBox(
                        height: size.height / 16,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                articleSingleController.catsArticle.length,
                            itemBuilder: ((context, index) {
                              return GestureDetector(
                                  onTap: () {
                                    String catId = articleSingleController
                                        .catsArticle[index].id;
                                    articleListController
                                        .getArticleListWithCatId(catId);

                                    String title = articleSingleController
                                        .catsArticle[index].title;
                                    Get.to(
                                        () => ArticleListScreen(title: title));
                                  },
                                  child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Container(
                                        height: size.height / 12.7,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            color: Color.fromARGB(
                                                255, 230, 230, 230)),
                                        child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                16, 8, 8, 8),
                                            child: Center(
                                              child: Text(
                                                articleSingleController
                                                    .catsArticle[index].title,
                                                style: articleTextFont,
                                              ),
                                            )),
                                      )));
                            })),
                      ),
                    ),

                    // relatedList
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 8,
                        right: 20,
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
                          Text('نوشته های مرتبط',
                              style: Theme.of(context).textTheme.subtitle1)
                        ],
                      ),
                    ),
                    RelatedArticle(
                      size: size,
                      texttheme: texttheme,
                      articleSingleController: articleSingleController,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
        ),
      )),
    );
  }
}

class Poster extends StatelessWidget {
  final ArticleSingleController articleSingleController;
  const Poster({
    Key? key,
    required this.size,
    required this.articleSingleController,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height / 3.5,
      child: Stack(
        children: [
          // poster
          Container(
            foregroundDecoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: GradiantColors.singlePoster,
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
            child: CachedNetworkImage(
                imageUrl: articleSingleController.articleInfo.value.image,
                imageBuilder: (context, imageProvider) =>
                    Image(image: imageProvider),
                placeholder: (context, url) => const SpinKitFadingCube(
                      color: SolidColors.primryColor,
                      size: 20,
                    ),
                errorWidget: (context, url, error) => Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: Image.asset(
                                Assets.images.singlePlaceHolder.path,
                              ).image,
                              fit: BoxFit.cover)),
                    )),
          ),
          //  row bala
          Positioned(
              top: 10,
              right: 0,
              left: 0,
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  const Icon(
                    Icons.bookmark_border_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () async {
                      await Share.share(
                          articleSingleController.articleInfo.value.title);
                    },
                    child: const Icon(
                      Icons.share,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  )
                ],
              ))
        ],
      ),
    );
  }
}

class RelatedArticle extends StatelessWidget {
  const RelatedArticle({
    Key? key,
    required this.size,
    required this.texttheme,
    required this.articleSingleController,
  }) : super(key: key);

  final Size size;
  final ArticleSingleController articleSingleController;
  final TextTheme texttheme;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
          height: size.height / 4.1,
          child: ListView.builder(
              itemCount: articleSingleController.relatedArticle.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: ((context, index) {
                // blog horizinal list
                return GestureDetector(
                  onTap: () {
                    articleSingleController.getArticleInfo(
                        articleSingleController.relatedArticle[index].id);
                  },
                  child: Padding(
                    padding:
                        EdgeInsets.fromLTRB(16, 0, index == 0 ? 20 : 16, 0),
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
                                imageUrl: articleSingleController
                                    .relatedArticle[index].image,
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
                                errorWidget: (context, url, error) =>
                                    const Icon(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    articleSingleController
                                        .relatedArticle[index].author,
                                    style: texttheme.bodyText1,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        articleSingleController
                                            .relatedArticle[index].view,
                                        style: texttheme.bodyText1,
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
                            articleSingleController.relatedArticle[index].title,
                            style: articleTextFont,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }))),
    );
  }
}
