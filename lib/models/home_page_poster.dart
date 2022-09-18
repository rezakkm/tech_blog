import 'package:tech_blog/components/my_api.dart';

class HomePagePoster {
  late String id;
  late String title;
  late String image;
  HomePagePoster({
    required this.id,
    required this.title,
    required this.image,
  });

  HomePagePoster.fromJson(Map<String, dynamic> element) {
    id = element['id'];
    title = element['title'];
    image = MyApi.baseUiUrl + element['image'];
  }
}


    // "id": "16",
    // "title": "اطلاعات جدیدی از بازی Assassin's Creed Mirage فاش شد",
    // "image": "/Techblog/assets/upload/images/article/20220904181457.jpg"
  