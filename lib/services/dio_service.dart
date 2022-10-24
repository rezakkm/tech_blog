import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio_service;

class DioService {
  Dio dio = Dio();

  Future<dynamic> getService(String url) async {
    dio.options.headers['content-Type'] = 'application/json';
    return await dio
        .get(url,
            options: Options(
              responseType: ResponseType.json,
              method: 'GET',
            ))
        .then((response) {
      return response;
    });
  }

  Future<dynamic> postService(Map<String, dynamic> map, String url) async {
    dio.options.headers['content-Type'] = 'application/json';

    // TODO read token from storage
    return await dio
        .post(url,
            data: dio_service.FormData.fromMap(map),
            options: Options(
              responseType: ResponseType.json,
              method: 'POST',
            ))
        .then((response) {
      log(response.headers.toString());
      log(response.statusCode.toString());
      log(response.data.toString());

      return response;
    });
  }
}
