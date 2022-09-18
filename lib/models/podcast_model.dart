import 'package:tech_blog/components/my_api.dart';

class PodcastModel {
  late String id;
  late String title;
  late String poster;
  late String publisher;
  late String view;
  late String createdAt;
  PodcastModel({
    required this.id,
    required this.title,
    required this.poster,
    required this.publisher,
    required this.view,
    required this.createdAt,
  });

  PodcastModel.fromJson(Map<String, dynamic> element) {
    id = element['id'];
    title = element['title'];
    poster = MyApi.baseUiUrl + element['poster'];
    publisher = element['publisher'];
    view = element['view'];
    createdAt = element['created_at'];
  }
}



      // "id": "8",
      // "title": "رادیوگیک ۱۴۳ – عاشقتم",
      // "poster": "/Techblog/assets/upload/images/podcast/images/20220707225803.jpg",
      // "publisher": "ساسان صفری",
      // "view": "36",
      // "created_at": "۱۴۰۱/۴/۱۶"
    