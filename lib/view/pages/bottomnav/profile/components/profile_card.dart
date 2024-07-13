import 'package:doss/constants/icons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../constants/colors.dart';
import '../../../../../utils/size_config.dart';

class ProfileCard extends StatelessWidget {
  final String title;
  const ProfileCard({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      height: SizeConfig.heightMultiplier*13,
      width: SizeConfig.widthMultiplier*47,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.darkGryClr,
      ),
      margin: EdgeInsets.only(right: SizeConfig.widthMultiplier*2.5),
      child: Padding(
        padding:  EdgeInsets.
        symmetric(horizontal: SizeConfig.widthMultiplier*5.0,
            vertical: SizeConfig.heightMultiplier*2.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(tr(title),
              style: textTheme.bodySmall,
            ),
            Image.asset(
              AppIcons.arrowForward,
              height: SizeConfig.imageSizeMultiplier*5,
              width: SizeConfig.imageSizeMultiplier*5,
            ),
          ],
        ),
      ),
    );
  }
}
