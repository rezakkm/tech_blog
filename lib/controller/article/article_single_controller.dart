import 'package:get/get.dart';
import 'package:tech_blog/models/article_info_model.dart';
import 'package:tech_blog/models/article_model.dart';
import 'package:tech_blog/models/tag_model.dart';
import 'package:tech_blog/services/dio_service.dart';
import 'package:tech_blog/view/article/article_single_screen.dart';

class ArticleSingleController extends GetxController {
  Rx<ArticleInfoModel> articleInfo = ArticleInfoModel(
          id: '',
          title: '',
          content: '',
          image: '',
          catId: '',
          catName: '',
          author: '',
          view: '',
          status: '',
          createdAt: '',
          isFavorite: true)
      .obs;
  Rx<ArticleInfoModel> articleSimple = ArticleInfoModel(
          id: '',
          title: '',
          content: '',
          image: '',
          catId: '',
          catName: '',
          author: '',
          view: '',
          status: '',
          createdAt: '',
          isFavorite: true)
      .obs;

  RxList<ArticleModel> relatedArticle = RxList();
  RxList<TagModel> catsArticle = RxList();
  RxBool loading = false.obs;

  getArticleInfo(var id) async {
    loading.value = true;
    Get.to(ArticleSingleScreen());

    // https://techblog.sasansafari.com/Techblog/api/article/get.php?command=info&id=1&user_id=1
    var response = await DioService().getService(
        'https://techblog.sasansafari.com/Techblog/api/article/get.php?command=info&id=$id&user_id=1');
    if (response.statusCode == 200) {
      print(response.data['tags']);
      loading.value = false;
      articleInfo.value = ArticleInfoModel.fromJson(response.data);

      relatedArticle.clear();
      response.data['related'].forEach((e) {
        relatedArticle.add(ArticleModel.fromJson(e));
      });
      catsArticle.clear();
      response.data['tags'].forEach((el) {
        catsArticle.add(TagModel.fromJson(el));
      });
    }
  }
}
