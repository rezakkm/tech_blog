import 'package:tech_blog/components/my_api.dart';

class PodcastModel {
  late String id;
  late String title;
  late String poster;
  late String catName;
  late String author;
  late String view;
  late String status;
  late String createdAt;
  PodcastModel({
    required this.id,
    required this.title,
    required this.poster,
    required this.catName,
    required this.author,
    required this.view,
    required this.status,
    required this.createdAt,
  });

  PodcastModel.fromJson(Map<String, dynamic> element) {
    id = element['id'];
    title = element['title'];
    poster = MyApi.baseUiUrl + element['poster'];
    catName = element['cat_name'];
    author = element['author'];
    view = element['view'];
    status = element['status'];
    createdAt = element['created_at'];
  }
}



      // "id": "8",
      // "title": "رادیوگیک ۱۴۳ – عاشقتم",
      // "poster": "/Techblog/assets/upload/images/podcast/images/20220707225803.jpg",
      // "publisher": "ساسان صفری",
      // "view": "36",
      // "created_at": "۱۴۰۱/۴/۱۶"
    