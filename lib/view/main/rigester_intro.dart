import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tech_blog/gen/assets.gen.dart';

import 'package:tech_blog/components/my_strings.dart';
import 'package:tech_blog/view/SignInInformation_screen.dart';
import 'package:validators/validators.dart';

class RigesterIntro extends StatelessWidget {
  const RigesterIntro({
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

class EmailRigesterBottomSheet extends StatefulWidget {
  final String order;
  final String hint;
  const EmailRigesterBottomSheet({
    Key? key,
    required this.order,
    required this.hint,
    required this.size,
    required this.textTheme,
  }) : super(key: key);

  final Size size;
  final TextTheme textTheme;

  @override
  State<EmailRigesterBottomSheet> createState() =>
      _EmailRigesterBottomSheetState();
}

class _EmailRigesterBottomSheetState extends State<EmailRigesterBottomSheet> {
  int index = 0;

  List<Color> textFieldList = [
    Colors.black,
    Colors.red,
    Colors.green,
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: widget.size.height / 2.3,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.order,
              style: widget.textTheme.subtitle2,
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: TextField(
                  onChanged: (value) {
                    if (isEmail(value) == true) {
                      setState(() {
                        index = 2;
                      });
                    }
                    if (isEmail(value) == false) {
                      setState(() {
                        index = 1;
                      });
                    }
                  },
                  textAlign: TextAlign.center,
                  showCursor: true,
                  decoration: InputDecoration(
                    floatingLabelAlignment: FloatingLabelAlignment.center,
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      color: textFieldList[index],
                      fontSize: 12,
                    ),
                    hintText: widget.hint,
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 200, 200, 200)),
                  )),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: ((context) {
                        return CodeRigesterBottomSHeet(
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
  final String order;
  final String hint;
  const CodeRigesterBottomSHeet({
    Key? key,
    required this.order,
    required this.hint,
    required this.size,
    required this.textTheme,
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
                  textAlign: TextAlign.center,
                  showCursor: true,
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 200, 200, 200)),
                  )),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => SignInInfo()));
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
