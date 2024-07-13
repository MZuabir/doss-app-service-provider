import 'package:doss/utils/spacing.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../constants/colors.dart';
import '../../../../../utils/size_config.dart';


class GridCard extends StatelessWidget {
  final String icon;
  final String title;
  const GridCard({Key? key, required this.icon,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Container(
          width: SizeConfig.widthMultiplier*17,
          height: SizeConfig.heightMultiplier*7.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.darkGryClr,
          ),
          child: Center(
              child: Image.asset(icon,
                height: SizeConfig.imageSizeMultiplier*6.5,
                width: SizeConfig.imageSizeMultiplier*6.5,
              )
          ),
        ),
        Spacing.y(1),
        SizedBox(
            width: SizeConfig.widthMultiplier*19,
            child: Text(tr(title),style: textTheme.bodySmall,textAlign: TextAlign.center,)),
      ],
    );
  }
}
