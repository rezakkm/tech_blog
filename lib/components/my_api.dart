class MyApi {
  static const String baseUiUrl = 'https://techblog.sasansafari.com';
  static const String baseUrl =
      'https://techblog.sasansafari.com/Techblog/api/';
  static const String getHomeItems = '${baseUrl}home/?command=index';
  static const String getArticleList =
      '${baseUrl}article/get.php?command=new&user_id=1';
  static const String publishedByMe =
      '${baseUrl}article/get.php?command=published_by_me&user_id=';
  static const String postMethodUrl = '${baseUrl}register/action.php';
  static const String postMethodStoreArticle =
      '$baseUrl/Techblog/api/article/post.php';
}
