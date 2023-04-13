import 'dart:developer';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tech_blog/components/storage_const.dart';
import 'package:tech_blog/controller/file_picker_controller.dart';

import '../../components/my_api.dart';
import '../../models/article_info_model.dart';
import '../../models/article_model.dart';
import '../../models/tag_model.dart';
import '../../services/dio_service.dart';

class ManageArticleController extends GetxController {
  RxList articleList = RxList.empty();
  RxBool loading = false.obs;
  RxList<TagModel> catsArticle = RxList();
  Rx<ArticleInfoModel> articleInfo = ArticleInfoModel(
          id: '',
          title: 'اینجا عنوان مقاله قرار میگیره ، یه عنوان جذاب انتخاب کن',
          content:
              '''من متن و بدنه اصلی مقاله هستم ، اگه میخوای من رو ویرایش کنی و یه مقاله جذاب بنویسی ، نوشته آبی رنگ بالا که نوشته "ویرایش متن اصلی مقاله" رو با انگشتت لمس کن تا وارد ویرایشگر بشی''',
          image: '',
          catId: '',
          catName: '',
          author: '',
          view: '',
          status: '',
          createdAt: '',
          isFavorite: true)
      .obs;
  TextEditingController titleTextEditingController = TextEditingController();

  @override
  onInit() {
    super.onInit();
    getArticleList();
  }

  updateTitle() {
    articleInfo.update((val) {
      val!.title = titleTextEditingController.text;
    });
  }

  getArticleList() async {
    loading.value = true;
    var response =
        // await DioService().getService(MyApi.publishedByMe + StorageKey.userId);
        await DioService().getService(
            '${MyApi.publishedByMe}${GetStorage().read(StorageKey.userId)}');
    if (response.statusCode == 200) {
      response.data.forEach((e) {
        articleList.add(ArticleModel.fromJson(e));
      });
    }
    loading.value = false;
  }

  postArticle() async {
    loading.value = true;

    var fileController = Get.find<FilePickerController>();
    Map<String, dynamic> map = {
      'title': articleInfo.value.title,
      'content': articleInfo.value.content,
      'cat_id': articleInfo.value.catId,
      'tag_list': '[]',
      'user_id': GetStorage().read(StorageKey.userId),
      'image':
          await dio.MultipartFile.fromFile(fileController.file.value.path!),
      'command': 'store'
    };
    var response = await DioService().postService(
        map, 'https://techblog.sasansafari.com/Techblog/api/article/post.php');
    log(response.data.toString());
    log(GetStorage().read(StorageKey.token));
    loading.value = false;
  }
}
