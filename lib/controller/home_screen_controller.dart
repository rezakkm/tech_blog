import 'package:get/get.dart';
import 'package:tech_blog/components/my_api.dart';
import 'package:tech_blog/models/article_model.dart';
import 'package:tech_blog/models/fake_data.dart';
import 'package:tech_blog/models/home_page_poster.dart';
import 'package:tech_blog/models/podcast_model.dart';
import 'package:tech_blog/models/tag_model.dart';
import 'package:tech_blog/services/dio_service.dart';

class HomeScreenController extends GetxController {
  late Rx<HomePagePoster> poster;

  RxList<TagModel> tagList = RxList();
  RxList<ArticleModel> topVisitedList = RxList();
  RxList<PodcastModel> topPodcasts = RxList();
  RxBool loading = false.obs;
  @override
  onInit() {
    super.onInit();
    getHomeItems();
  }

  getHomeItems() async {
    loading.value = true;
    var response = await DioService().getService(MyApi.getHomeItems);

    if (response.statusCode == 200) {
      poster = HomePagePoster.fromJson(response.data["poster"]).obs;
      response.data['top_visited'].forEach((element) {
        topVisitedList.add(ArticleModel.fromJson(element));
      });
      response.data["top_podcasts"].forEach((element) {
        topPodcasts.add(PodcastModel.fromJson(element));
      });
      response.data["tags"].forEach((element) {
        tagList.add(TagModel.fromJson(element));
      });
      loading.value = false;
    }
  }
}
