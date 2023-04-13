import 'package:get/get.dart';
import 'package:tech_blog/components/my_api.dart';
import 'package:tech_blog/models/article_model.dart';
import 'package:tech_blog/services/dio_service.dart';

class ArticleListController extends GetxController {
  RxList<ArticleModel> articleList = RxList();
  RxBool loading = false.obs;

  @override
  onInit() {
    super.onInit();
    getArticleList();
  }

  getArticleList() async {
    loading.value = true;
    var response = await DioService().getService(MyApi.getArticleList);
    if (response.statusCode == 200) {
      response.data.forEach((e) {
        articleList.add(ArticleModel.fromJson(e));
        loading.value = false;
      });
    }
  }

  getArticleListWithCatId(String id) async {
    articleList.clear();
    // https://techblog.sasansafari.com/Techblog/api/article/get.php?command=get_articles_with_cat_id&cat_id=1&user_id=1
    loading.value = true;
    var response = await DioService().getService(
        'https://techblog.sasansafari.com/Techblog/api/article/get.php?command=get_articles_with_cat_id&cat_id=$id&user_id=1');
    if (response.statusCode == 200) {
      response.data.forEach((e) {
        articleList.add(ArticleModel.fromJson(e));
        loading.value = false;
      });
    }
  }

  getArticleListWithTagId(String id) async {
    articleList.clear();
    // https://techblog.sasansafari.com/Techblog/api/article/get.php?command=get_articles_with_tag_id&tag_id=1&user_id=1
    loading.value = true;
    var response = await DioService().getService(
        'https://techblog.sasansafari.com/Techblog/api/article/get.php?command=get_articles_with_tag_id&tag_id=$id&user_id=1');
    if (response.statusCode == 200) {
      response.data.forEach((e) {
        articleList.add(ArticleModel.fromJson(e));
        loading.value = false;
      });
    }
  }
}
