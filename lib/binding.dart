import 'package:get/get.dart';
import 'package:tech_blog/controller/article/article_list_controller.dart';
import 'package:tech_blog/controller/article/article_single_controller.dart';
import 'package:tech_blog/controller/article/manage_article_controller.dart';
import 'package:tech_blog/view/article/article_single_screen.dart';

import 'controller/register_controller.dart';

class ArticleBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(ArticleListController());
    Get.lazyPut(() => ArticleSingleController());
  }
}

class RegisterBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(RegisterController());
  }
}

class ManageArticleBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(ManageArticleController());
    Get.lazyPut(() => ArticleSingleController());
  }
}
