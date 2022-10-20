import 'package:get/get.dart';
import 'package:tech_blog/components/my_api.dart';
import 'package:tech_blog/models/article_model.dart';
import 'package:tech_blog/models/tag_model.dart';
import 'package:tech_blog/services/dio_service.dart';
import 'package:tech_blog/view/single_article_screen.dart';

import '../models/article_info_model.dart';

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
  RxList<TagModel> catArticle = RxList();
  RxBool loading = false.obs;
  @override
  onInit() {
    super.onInit();
  }

  getArticleInfo(var id) async {
    loading.value = true;
    Get.to(SingleArticleScreen());

    // https://techblog.sasansafari.com/Techblog/api/article/get.php?command=info&id=1&user_id=1
    var response = await DioService().getService(
        'https://techblog.sasansafari.com/Techblog/api/article/get.php?command=info&id=$id&user_id=1');
    if (response.statusCode == 200) {
      loading.value = false;
      articleInfo.value = ArticleInfoModel.fromJson(response.data);

      relatedArticle.clear();
      response.data['related'].forEach((e) {
        relatedArticle.add(ArticleModel.fromJson(e));
      });
      catArticle.clear();
      response.data['tags'].forEach((e) {
        catArticle.add(TagModel.fromJson(e));
      });
    }
  }
}
