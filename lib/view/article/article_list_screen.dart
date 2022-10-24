import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tech_blog/components/my_text_style.dart';
import 'package:tech_blog/controller/article_list_controller.dart';

import '../../components/my_colors.dart';
import '../../components/my_component.dart';
import '../../controller/article_single_controller.dart';

class ArticleListScreen extends StatelessWidget {
  final String title;
  const ArticleListScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    ArticleListController articleListController =
        Get.put(ArticleListController());
    ArticleSingleController articleSingleController =
        Get.put(ArticleSingleController());
    return Obx(() => Scaffold(
        appBar: primryAppBar(title),
        body: articleListController.loading.value == true
            // loading page
            ? Column(children: [
                SizedBox(
                  height: size.height / 2.7,
                ),
                const SpinKitFadingCube(
                  color: SolidColors.primryColor,
                  size: 32,
                )
              ])
            // ArticleList
            : SizedBox(
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: articleListController.articleList.length,
                    itemBuilder: ((context, index) {
                      return GestureDetector(
                        onTap: () {
                          articleSingleController.getArticleInfo(
                              articleListController.articleList[index].id);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Container(
                            width: size.width / 1.25,
                            height: size.height / 6.5,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 15,
                                      offset: Offset(5, 5)),
                                  BoxShadow(
                                      color: Colors.white,
                                      blurRadius: 15,
                                      offset: Offset(-5, -5))
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16))),
                            child: Row(
                              children: [
                                Container(
                                  width: size.width / 3,
                                  height: size.height / 6.5,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(16))),
                                  child: CachedNetworkImage(
                                    imageUrl: articleListController
                                        .articleList[index].image,
                                    imageBuilder: (context, imageProvider) {
                                      return Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
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
                                Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        SizedBox(
                                          width: Get.width / 1.9,
                                          child: Text(
                                            articleListController
                                                .articleList[index].title,
                                            style: textTheme.headline3,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                            articleListController
                                                .articleList[index].author,
                                            style: viewTextArticleList),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'بازدید: ${articleListController.articleList[index].view}',
                                          style: viewTextArticleList,
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          articleListController
                                              .articleList[index].catName,
                                          style: catTextArticleList,
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    })),
              )));
  }
}
