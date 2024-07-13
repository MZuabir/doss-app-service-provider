import 'package:doss/constants/colors.dart';
import 'package:doss/utils/size_config.dart';
import 'package:doss/utils/spacing.dart';
import 'package:doss/view/widgets/custom_button.dart';
import 'package:doss/view/widgets/loading.dart';
import 'package:doss/view/widgets/txt_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBottomSheet extends StatelessWidget {
  final String icon;
  final String btnTitle;
  final String title;
  final Function()? onTap;
  final bool Loading;
  const CustomBottomSheet(
      {super.key,
      required this.icon,
      this.onTap,
      required this.btnTitle,
      required this.title,
      this.Loading = false});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      height: SizeConfig.heightMultiplier * 38,
      color: Colors.black,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 2.5),
        child: ShowLoading(
          inAsyncCall: Loading,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Spacing.y(5),
              CircleAvatar(
                radius: 23,
                backgroundColor: AppColors.darkGryClr,
                child: Image.asset(
                  icon,
                  color: AppColors.primaryClr,
                  height: SizeConfig.imageSizeMultiplier * 7,
                  width: SizeConfig.imageSizeMultiplier * 7,
                ),
              ),
              Spacing.y(3),
              Text(
                tr(title),
                style: textTheme.headlineMedium!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              Spacing.y(3),
              CustomButton(
                title: tr(btnTitle),
                onTap: onTap,
              ),
              Spacing.y(2),
              CustomTextBtn(
                title: "To go back",
                onTap: () {
                  Get.back();
                },
              ),
              Spacing.y(3),
            ],
          ),
        ),
      ),
    );
  }
}
