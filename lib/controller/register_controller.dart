// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tech_blog/components/my_api.dart';
import 'package:tech_blog/components/storage_const.dart';
import 'package:tech_blog/services/dio_service.dart';
import 'package:tech_blog/view/main/main_screen.dart';

import '../view/main/signIn/rigester_intro.dart';

class RegisterController extends GetxController {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController activeCodeTextEditingController =
      TextEditingController();
  String email = '';
  String userId = '';

  register() async {
    Map<String, dynamic> map = {
      'email': emailTextEditingController.text,
      'command': 'register'
    };
    email = emailTextEditingController.text;

    var response = await DioService().postService(map, MyApi.postMethodUrl);
    userId = response.data['user_id'];

    debugPrint(response);
  }

  verify() async {
    Map<String, dynamic> map = {
      'email': emailTextEditingController.text,
      'user_id': userId,
      'code': activeCodeTextEditingController.text,
      'command': 'verify'
    };
    debugPrint(map.toString());
    final response = await DioService().postService(map, MyApi.postMethodUrl);
    debugPrint(response);
    if (response.data['response'] == 'verified') {
      var box = GetStorage();
      box.write(storageToken, response.data['token']);
      box.write(storageUserId, response.data['user_id']);
      debugPrint('Token is::::::   ' + box.read(storageToken));
      debugPrint('User Id is::::::   ' + box.read(storageUserId));
      Get.to(() => MainScreen());
    } else {
      log('error');
    }
  }

  checkLogIn() {
    if (GetStorage().read(storageToken) == null) {
      Get.to(() => RigesterIntro());
    } else {
      debugPrint(r'you are LogIn');
    }
  }
}
