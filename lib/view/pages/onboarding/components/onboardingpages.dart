import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../utils/size_config.dart';
import '../../../../utils/spacing.dart';

class OnBoardingPages extends StatelessWidget {
  final String title;
  final String image;
  final String description;
  const OnBoardingPages({Key? key, required this.title, required this.image, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Spacing.y(20),
        Image.asset(image,
          height: SizeConfig.imageSizeMultiplier*78,
          width: SizeConfig.imageSizeMultiplier*78,
        ),
        Spacing.y(5),
        Text(title,
          style:textTheme.headlineMedium,
        ).tr(),
        Spacing.y(2),
        Text(
          description,
          textAlign: TextAlign.center,
          style:textTheme.bodyMedium,
        ).tr(),
      ],
    );
  }
}