import 'package:tech_blog/components/my_api.dart';

class ArticleModel {
  late String id;
  late String title;
  late String image;
  late String catId;
  late String catName;
  late String author;
  late String view;
  late String status;
  late String createdAt;

  ArticleModel({
    required this.id,
    required this.title,
    required this.image,
    required this.catId,
    required this.catName,
    required this.author,
    required this.view,
    required this.status,
    required this.createdAt,
  });

  ArticleModel.fromJson(Map<String, dynamic> element) {
    id = element['id'];
    title = element['title'];
    image = MyApi.baseUiUrl + element['image'];
    catId = element['cat_id'];
    catName = element['cat_name'];
    author = element['author'];
    view = element['view'];
    status = element['status'];
    createdAt = element['created_at'];
  }
}




      // "id": "16",
      // "title": "اطلاعات جدیدی از بازی Assassin's Creed Mirage فاش شد",
      // "image": "/Techblog/assets/upload/images/article/20220904181457.jpg",
      // "cat_id": "3",
      // "cat_name": "اخبار بازی",
      // "author": "محسن چگینی",
      // "view": "338",
      // "status": "1",
      // "created_at": "۱۴۰۱/۶/۱۲"
    