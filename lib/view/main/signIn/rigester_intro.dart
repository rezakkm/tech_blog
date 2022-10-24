import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tech_blog/controller/register_controller.dart';
import 'package:tech_blog/gen/assets.gen.dart';

import 'package:tech_blog/components/my_strings.dart';

import 'package:validators/validators.dart';

class RigesterIntro extends StatelessWidget {
  RegisterController registerController = Get.put(RegisterController());
  RigesterIntro({
    Key? key,
    required this.size,
    required this.textTheme,
  }) : super(key: key);

  final Size size;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(children: [
        SizedBox(
          height: size.height / 3.5,
        ),
        // techbot
        SvgPicture.asset(
          Assets.icons.techBot.path,
          width: size.width / 3.56,
        ),
        SizedBox(
          height: size.height / 50,
        ),
        // text
        RichText(
          text:
              TextSpan(text: MyStrings.welcomeText, style: textTheme.subtitle2),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: size.height / 20),
        ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                context: context,
                builder: ((context) {
                  return EmailRigesterBottomSheet(
                    registerController: registerController,
                    size: size,
                    textTheme: textTheme,
                    hint: 'techblog@gmail.com',
                    order: 'لطفا ایمیلت رو وارد کن',
                  );
                }));
          },
          child: const Text(
            MyStrings.letsGo,
          ),
        )
      ]),
    ));
  }
}

class EmailRigesterBottomSheet extends StatelessWidget {
  final String order;
  final String hint;
  final Size size;
  final TextTheme textTheme;
  final RegisterController registerController;
  EmailRigesterBottomSheet({
    Key? key,
    required this.order,
    required this.hint,
    required this.size,
    required this.textTheme,
    required this.registerController,
  }) : super(key: key);

  RxInt index = 0.obs;

  RxList<Color> textFieldList = [
    Colors.black,
    Colors.red,
    Colors.green,
  ].obs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: size.height / 2.3,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              order,
              style: textTheme.subtitle2,
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Obx(
                () => TextField(
                    controller: registerController.emailTextEditingController,
                    onChanged: (value) {
                      if (isEmail(value) == true) {
                        index.value = 2;
                      }
                      if (isEmail(value) == false) {
                        index.value = 1;
                      }
                    },
                    textAlign: TextAlign.center,
                    showCursor: true,
                    decoration: InputDecoration(
                      floatingLabelAlignment: FloatingLabelAlignment.center,
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        color: textFieldList[index.value],
                        fontSize: 12,
                      ),
                      hintText: hint,
                      hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 200, 200, 200)),
                    )),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  registerController.register();
                  Navigator.pop(context);
                  showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: ((context) {
                        return CodeRigesterBottomSHeet(
                            registerController: registerController,
                            order: 'کد فعال سازی رو وارد کن ',
                            hint: '******',
                            size: MediaQuery.of(context).size,
                            textTheme: Theme.of(context).textTheme);
                      }));
                },
                child: const Text(
                  '   ادامه   ',
                ))
          ],
        ),
      ),
    );
  }
}

class CodeRigesterBottomSHeet extends StatelessWidget {
  final RegisterController registerController;
  final String order;
  final String hint;
  const CodeRigesterBottomSHeet({
    Key? key,
    required this.order,
    required this.hint,
    required this.size,
    required this.textTheme,
    required this.registerController,
  }) : super(key: key);

  final Size size;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: size.height / 2.3,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              order,
              style: textTheme.subtitle2,
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: TextField(
                  controller:
                      registerController.activeCodeTextEditingController,
                  textAlign: TextAlign.center,
                  showCursor: true,
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 200, 200, 200)),
                  )),
            ),
            ElevatedButton(
                onPressed: () async {
                  registerController.verify();
                  // Get.to(() => SignInInfo());
                },
                child: const Text(
                  '   ادامه   ',
                ))
          ],
        ),
      ),
    );
  }
}
