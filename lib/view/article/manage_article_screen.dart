import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tech_blog/components/my_component.dart';
import 'package:tech_blog/components/my_text_style.dart';
import 'package:tech_blog/controller/article/manage_article_controller.dart';
import 'package:tech_blog/gen/assets.gen.dart';
import 'package:tech_blog/main.dart';
import 'package:tech_blog/view/article/post_article_screen.dart';
import '../../components/my_colors.dart';

class ManageArticleScreen extends StatelessWidget {
  var manageArticleController = Get.find<ManageArticleController>();
  ManageArticleScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    return Obx(
      () => Scaffold(
          appBar: primryAppBar('مدیریت مقاله ها'),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(30),
            child: SizedBox(
              width: Get.width / 3,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(PostArticleScreen());
                },
                child: Text(
                  'بریم برای نوشتن یه مقاله باحال',
                  style: buttonFont,
                ),
              ),
            ),
          ),
          body: manageArticleController.loading.value
              ? LoadingPage(size)
              : manageArticleController.articleList.isNotEmpty
                  // loading page
                  ? SizedBox(
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: manageArticleController.articleList.length,
                          itemBuilder: ((context, index) {
                            return GestureDetector(
                              onTap: () async {},
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(16))),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: size.width / 3,
                                        height: size.height / 6.5,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(16))),
                                        child: CachedNetworkImage(
                                          imageUrl: manageArticleController
                                              .articleList[index].image,
                                          imageBuilder:
                                              (context, imageProvider) {
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
                                                  manageArticleController
                                                      .articleList[index].title,
                                                  style: textTheme.headline3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                                  manageArticleController
                                                      .articleList[index]
                                                      .author,
                                                  style: viewTextArticleList),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'بازدید: ${manageArticleController.articleList[index].view}',
                                                style: viewTextArticleList,
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                manageArticleController
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
                    )
                  : EmptyState(size: size, textTheme: textTheme)),
    );
  }
}

class EmptyState extends StatelessWidget {
  const EmptyState({
    Key? key,
    required this.size,
    required this.textTheme,
  }) : super(key: key);

  final size;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        SizedBox(
          height: size.height / 3.5,
        ),
        // techbot
        Image.asset(
          Assets.images.emtyState.path,
          width: size.width / 3.56,
        ),
        SizedBox(
          height: size.height / 50,
        ),
        // text
        RichText(
          text: TextSpan(text: """هنوز هیچ مقاله ای به جامعه گیک های فارسی 
اضافه نکردی !!!""", style: textTheme.subtitle2),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: size.height / 4),
      ]),
    );
  }
}
