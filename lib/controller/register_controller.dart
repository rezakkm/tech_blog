// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tech_blog/binding.dart';
import 'package:tech_blog/components/my_api.dart';
import 'package:tech_blog/components/storage_const.dart';
import 'package:tech_blog/gen/assets.gen.dart';
import 'package:tech_blog/main.dart';
import 'package:tech_blog/services/dio_service.dart';
import 'package:tech_blog/view/main/main_screen.dart';

import '../components/my_text_style.dart';
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
    var response = await DioService().postService(map, MyApi.postMethodUrl);
    debugPrint(response.data.toString());
    var status = response.data['response'];

    switch (status) {
      case 'verified':
        var box = GetStorage();
        box.write(StorageKey.token, response.data['token']);
        box.write(StorageKey.userId, response.data['user_id']);

        debugPrint("read::: " + box.read(StorageKey.token));
        debugPrint("read::: " + box.read(StorageKey.userId));

        Get.offAllNamed(RouteNamed.mainScreen);

        break;
      case 'incorrect_code':
        Get.snackbar('خطا', 'کد فعالسازی غلط است');
        break;
      case 'expired':
        Get.snackbar('خطا', 'کد فعالسازی منقضی شده است');

        break;
    }
  }

  checkLogIn() {
    if (GetStorage().read(StorageKey.token) == null) {
      Get.to(RigesterIntro());
    } else {
      writeBottomSheet();
    }
  }

  writeBottomSheet() {
    Get.bottomSheet(Container(
      height: Get.height / 3,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 25, 16, 16),
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  Assets.icons.techBot.path,
                  height: 40,
                ),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  'دونسته هات رو با بقیه به اشتراک بذار ...',
                  style: articleTextFont,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              """ فکر کن !!  اینجا بودنت به این معناست که یک گیک تکنولوژی هستی
دونسته هات رو با  جامعه‌ی گیک های فارسی زبان به اشتراک بذار..""",
              style: dateSubmitArticle,
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => Get.toNamed(RouteNamed.manageArticleScreen),
                  child: Container(
                    color: Colors.white,
                    child: Row(
                      children: [
                        Image.asset(
                          Assets.images.write.path,
                          height: 40,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          'مدیریت مقاله ها',
                          style: articleTextFont,
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => debugPrint('route to podcast'),
                  child: Container(
                    color: Colors.white,
                    child: Row(
                      children: [
                        Image.asset(
                          Assets.images.podcast.path,
                          height: 40,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          'مدیریت پادکست ها',
                          style: articleTextFont,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
