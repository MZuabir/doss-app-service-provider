import 'package:doss/constants/colors.dart';
import 'package:doss/constants/cont.dart';
import 'package:doss/constants/icons.dart';
import 'package:doss/utils/spacing.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/size_config.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar(
      {super.key,
      required this.title,
      this.onTap,
      this.isIcon = false,
      this.icon,
      this.onBackBtnTap});

  final String title;
  final VoidCallback? onTap;
  final bool isIcon;
  final String? icon;
  final VoidCallback? onBackBtnTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: onBackBtnTap ?? () => Get.back(),
          child: Icon(
            Icons.arrow_back,
            size: SizeConfig.imageSizeMultiplier * 6,
            color: AppColors.whiteClr,
          ),
        ),
        const Spacer(),
        Text(tr(title),
            textAlign: TextAlign.center,
            style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600)),
        const Spacer(),
        isIcon ? Spacing.x(0) : Spacing.x(5),
        isIcon
            ? InkWell(
                onTap: onTap,
                child: Image.asset(
                  icon ?? AppIcons.add,
                  height: SizeConfig.imageSizeMultiplier * 8,
                  width: SizeConfig.imageSizeMultiplier * 8,
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
