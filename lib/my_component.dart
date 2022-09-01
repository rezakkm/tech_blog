import 'package:flutter/material.dart';
import 'gen/assets.gen.dart';
import 'models/fake_data.dart';
import 'my_colors.dart';

class TechDivider extends StatelessWidget {
  const TechDivider({
    Key? key,
    required this.bodyMargin,
  }) : super(key: key);

  final double bodyMargin;

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: SolidColors.dividerColor,
      thickness: 0.5,
      indent: bodyMargin * 2,
      endIndent: bodyMargin * 2,
    );
  }
}

class SimpleOfTagList extends StatelessWidget {
  const SimpleOfTagList(
      {Key? key,
      required this.size,
      required this.index,
      required this.biuldList})
      : super(key: key);

  final Size size;
  final int index;
  final List biuldList;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height / 12.7,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          gradient: LinearGradient(
              colors: GradiantColors.hashtags,
              begin: Alignment.centerRight,
              end: Alignment.centerLeft)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
        child: Row(
          children: [
            ImageIcon(
              Image.asset(
                Assets.icons.hashtag.path,
              ).image,
              color: Colors.white,
              size: 12,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(biuldList[index].title)
          ],
        ),
      ),
    );
  }
}

class SimpleOfFavTag extends StatelessWidget {
  const SimpleOfFavTag(
      {Key? key,
      required this.size,
      required this.index,
      required this.biuldList})
      : super(key: key);

  final Size size;
  final int index;
  final List biuldList;

  @override
  Widget build(BuildContext context) {
    var texttheme = Theme.of(context).textTheme;
    return Container(
      height: size.height / 12.7,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Color.fromARGB(255, 230, 230, 230)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox.shrink(),
            Text(
              biuldList[index].title,
              style: texttheme.headline3,
            ),
            const Icon(
              Icons.remove_sharp,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
