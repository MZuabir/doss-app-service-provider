import 'package:doss/constants/colors.dart';
import 'package:doss/utils/size_config.dart';
import 'package:doss/utils/spacing.dart';
import 'package:doss/view/widgets/custom_button.dart';
import 'package:doss/view/widgets/loading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/cont.dart';

class AuthBottomSheet extends StatelessWidget {
  final String icon;
  final String btnTitle;
  final String title;
  final String description;
  final Function()? onTap;
  const AuthBottomSheet({super.key, required this.icon, this.onTap, required this.btnTitle, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      color: Colors.black,
      height: SizeConfig.heightMultiplier*40,
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier*2.5),
        child: Obx(
          ()=> ShowLoading(
            inAsyncCall: authCont.isLoading.value,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Spacing.y(5),
                CircleAvatar(
                  radius: 23,
                  backgroundColor: AppColors.darkGryClr,
                  child: Image.asset(icon,
                    height: SizeConfig.imageSizeMultiplier*7,
                    width: SizeConfig.imageSizeMultiplier*7,
                  ),
                ),
                Spacing.y(3),
                Text(
                  tr(title),
                  style: textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w600),
                ),
                Spacing.y(3),
                Text(tr(description),
                  style: textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
                Spacing.y(3),
                CustomButton(title: tr(btnTitle), onTap:onTap,
                ),
                Spacing.y(5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




