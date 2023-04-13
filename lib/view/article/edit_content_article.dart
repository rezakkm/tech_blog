import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';

import 'package:tech_blog/components/my_component.dart';

import '../../controller/article/manage_article_controller.dart';

// ignore: must_be_immutable
class ArticleContentEditor extends StatelessWidget {
  ArticleContentEditor({Key? key}) : super(key: key);

  final HtmlEditorController controller = HtmlEditorController();
  var manageArticleController = Get.put(ManageArticleController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.clearFocus(),
      child: Scaffold(
        appBar: primryAppBar("نوشتن/ویرایش مقاله "),
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HtmlEditor(
              controller: controller,
              htmlEditorOptions: HtmlEditorOptions(
                  darkMode: true,
                  hint: "میتونی مقاله‌تو اینجا بنویسی...",
                  shouldEnsureVisible: true,
                  initialText:
                      manageArticleController.articleInfo.value.content!),
              callbacks: Callbacks(
                onChangeContent: (p0) {
                  manageArticleController.articleInfo.update(
                    (val) {
                      val?.content = p0!;
                    },
                  );
                },
              ),
            )
          ],
        )),
      ),
    );
  }
}
