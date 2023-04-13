class TagModel {
  late String title;
  late String id;

  TagModel({
    required this.title,
    required this.id,
  });

  TagModel.fromJson(Map<String, dynamic> element) {
    id = element['id'];
    title = element['title'];
  }
}


// "id": "7",
//       "title": "آیفون"
    