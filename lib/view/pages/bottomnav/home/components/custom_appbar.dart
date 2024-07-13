import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doss/constants/cont.dart';
import 'package:doss/view/pages/bottomnav/profile/profile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/icons.dart';
import '../../../../../utils/size_config.dart';
import '../../../../../utils/spacing.dart';
import '../../../notification/notifications.dart';

class CustomHomeAppbar extends StatelessWidget {
  const CustomHomeAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome to)!",
              style: textTheme.headlineSmall,
            ).tr(),
            Spacing.y(0.5),
            Text(
             Get.locale?.countryCode == "US"
                  ? DateFormat.yMMMMd('en_US').format(DateTime.now())
                  : DateFormat.yMMMMd('pt_BR').format(DateTime.now()),
              style: textTheme.bodySmall,
            ),
          ],
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            Get.to(
              () => NotificationPage(),
              transition: Transition.rightToLeft,
            );
          },
          child: CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.darkGryClr,
            child: Image.asset(
              AppIcons.notification,
              height: SizeConfig.imageSizeMultiplier * 6,
              width: SizeConfig.imageSizeMultiplier * 6,
            ),
          ),
        ),
        Spacing.x(4),
        InkWell(
          onTap: () => authCont.bnbIndex.value = 3,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 21,
            child: Obx(() => CachedNetworkImage(
                  imageUrl: authCont.getUserMoreInfo?.data.photoUrl ?? "",
                  placeholder: (_, p_o) => CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.darkGryClr,
                    child: CupertinoActivityIndicator(
                        radius: 8, color: Colors.white),
                  ),
                  errorWidget: (_, e, o) => CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.primaryClr,
                    child: Text(
                      "!",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  ),
                  imageBuilder: (_, img) => CircleAvatar(
                      radius: 20,
                      backgroundColor: AppColors.darkGryClr,
                      backgroundImage: img),
                )),
          ),
        ),
      ],
    );
  }
}
