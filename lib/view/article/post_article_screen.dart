import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

import 'package:tech_blog/components/my_colors.dart';

import 'package:tech_blog/components/my_text_style.dart';

import 'package:tech_blog/controller/article/manage_article_controller.dart';
import 'package:tech_blog/controller/file_picker_controller.dart';
import 'package:tech_blog/gen/assets.gen.dart';
import 'package:tech_blog/services/pick_file.dart';

import '../../components/my_component.dart';

import '../../controller/home_screen_controller.dart';
import 'edit_content_article.dart';

class PostArticleScreen extends StatelessWidget {
  var manageArticleController = Get.find<ManageArticleController>();

  PostArticleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    var texttheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Obx(
        () => Scaffold(
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(30),
            child: SizedBox(
              width: Get.width / 3,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  manageArticleController.postArticle();
                },
                child: manageArticleController.loading.value
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Text('صبر کنید...'),
                          SpinKitFadingCube(
                            color: Colors.white,
                            size: 15,
                          )
                        ],
                      )
                    : Text(
                        'تموم شد',
                        style: buttonFont,
                      ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: manageArticleController.loading.value == true
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
                          manageArticleController: manageArticleController),
                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Column(
                          children: [
                            // edit title
                            GestureDetector(
                              onTap: () {
                                editTitle();
                              },
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
                                  Text('ویرایش عنوان مقاله',
                                      style: titleForEdit)
                                ],
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: size.height / 12,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, top: 10, right: 10),
                                child: Text(
                                  manageArticleController
                                      .articleInfo.value.title,
                                  overflow: TextOverflow.ellipsis,
                                  style: titleArticleSingleScreen,
                                  maxLines: 2,
                                ),
                              ),
                            ),
                            // edit content
                            GestureDetector(
                              onTap: () {
                                Get.to(() => ArticleContentEditor());
                              },
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
                                  Text('ویرایش متن اصلی مقاله',
                                      style: titleForEdit)
                                ],
                              ),
                            ),

                            SizedBox(
                              height: size.height / 40,
                            ),
                            // content
                            Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 30,
                                  left: 30,
                                ),
                                child: HtmlWidget(
                                  textStyle: articleTextFont,
                                  manageArticleController
                                      .articleInfo.value.content,
                                  enableCaching: true,
                                  onLoadingBuilder:
                                      ((context, element, loadingProgress) =>
                                          loading()),
                                )),

                            // edit cats
                            GestureDetector(
                              onTap: () {
                                chooseCatsBottomSheet();
                              },
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
                                  Text('انتخاب دسته بندی', style: titleForEdit)
                                ],
                              ),
                            ),
                            // cat list biulder
                            manageArticleController.articleInfo.value.catName ==
                                    ''
                                ? Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, right: 20),
                                      child: Text(
                                        'دسته‌ای انتخاب نشده است!',
                                        style: emptyCats,
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, right: 20),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        width: 100,
                                        height: 40,
                                        decoration: const BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 155, 155, 155),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(16))),
                                        child: Center(
                                          child: Text(
                                              manageArticleController
                                                  .articleInfo.value.catName,
                                              style: buttonFont),
                                        ),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  chooseCatsBottomSheet() {
    var homeScreenController = Get.find<HomeScreenController>();
    Get.bottomSheet(
      isScrollControlled: true,
      persistent: true,
      Container(
        height: Get.height / 2,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Text(
              'انتخاب دسته‌بندی',
              style: titleArticleSingleScreen,
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: SizedBox(
                height: Get.height / 2.3,
                child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5),
                    scrollDirection: Axis.vertical,
                    itemCount: homeScreenController.tagList.length,
                    itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              manageArticleController.articleInfo.update((val) {
                                val!.catId =
                                    homeScreenController.tagList[index].id;
                                val.catName =
                                    homeScreenController.tagList[index].title;
                              });
                              Get.back();
                            },
                            child: Container(
                              width: 80,
                              height: 30,
                              decoration: const BoxDecoration(
                                  color: SolidColors.primryColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16))),
                              child: Center(
                                  child: Text(
                                homeScreenController.tagList[index].title,
                                style: buttonFont,
                              )),
                            ),
                          ),
                        )),
              ),
            )
          ]),
        ),
      ),
    );
  }

  editTitle() {
    Get.defaultDialog(
        title: "عنوان مقاله",
        titleStyle: buttonFont,
        backgroundColor: const Color.fromARGB(255, 68, 4, 87),
        content: TextField(
          controller: manageArticleController.titleTextEditingController,
          style: const TextStyle(color: Colors.white),
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
              hintText: 'اینجا بنویس',
              hintStyle: TextStyle(color: Color.fromARGB(255, 189, 189, 189))),
        ),
        confirm: ElevatedButton(
            onPressed: () {
              manageArticleController.updateTitle();
              Get.back();
            },
            child: Text(
              'ثبت',
              style: buttonFont,
            )));
  }
}

class Poster extends StatelessWidget {
  final ManageArticleController manageArticleController;
  Poster({
    Key? key,
    required this.size,
    required this.manageArticleController,
  }) : super(key: key);
  FilePickerController filePickerController = Get.put(FilePickerController());
  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height / 3.5,
      child: Stack(
        children: [
          // poster
          Obx(
            () => Container(
              width: Get.width,
              height: Get.height / 3,
              foregroundDecoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: GradiantColors.singlePoster,
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
              child: filePickerController.file.value.name == 'nothing'
                  ? CachedNetworkImage(
                      imageUrl: manageArticleController.articleInfo.value.image,
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
                          ))
                  : Image.file(
                      File(filePickerController.file.value.path!),
                      fit: BoxFit.cover,
                    ),
            ),
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
                ],
              )),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    pickFile();
                  },
                  child: Container(
                    width: Get.width / 3,
                    height: 40,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 117, 22, 146),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'انتخاب تصویر',
                          style: buttonFont,
                        ),
                        const Icon(
                          Icons.add,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
