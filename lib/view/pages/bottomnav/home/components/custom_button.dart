import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/icons.dart';
import '../../../../../utils/size_config.dart';


class HomeButton extends StatelessWidget {
  final  Function()? onTap;
  const HomeButton({Key? key,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: SizeConfig.heightMultiplier*5,
        width: SizeConfig.widthMultiplier*48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: AppColors.redClr,
        ),
        child: Padding(
          padding:  EdgeInsets.only(left:SizeConfig.widthMultiplier*14,right: SizeConfig.widthMultiplier*4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Emergency",
                style: textTheme.bodyMedium,
              ).tr(),
              Image.asset(
                AppIcons.warning,
                height: SizeConfig.imageSizeMultiplier*5,
                width: SizeConfig.imageSizeMultiplier*5,
              )
            ],
          ),
        ),
      ),
    );
  }
}
