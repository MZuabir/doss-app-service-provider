import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doss/constants/cont.dart';
import 'package:doss/controllers/auth.dart';
import 'package:doss/controllers/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../constants/colors.dart';
import '../../../../../utils/size_config.dart';
import '../../../../../utils/spacing.dart';

class StatusTile extends StatefulWidget {
  const StatusTile({Key? key}) : super(key: key);

  @override
  State<StatusTile> createState() => _StatusTileState();
}

class _StatusTileState extends State<StatusTile> {
  final cont = Get.put(HomeCont());

  @override
  Widget build(BuildContext context) {
   
    final textTheme = Theme.of(context).textTheme;
    return Container(
      height: SizeConfig.heightMultiplier * 9.5,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.darkGryClr,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.widthMultiplier * 5.0,
            vertical: SizeConfig.heightMultiplier * 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 17,
              child: Obx(() => CachedNetworkImage(
                    imageUrl: authCont.getUserMoreInfo?.data.photoUrl ?? "",
                    placeholder: (_, p_o) => CircleAvatar(
                      radius: 16,
                      backgroundColor: AppColors.darkGryClr,
                      child: CupertinoActivityIndicator(
                          radius: 8, color: Colors.white),
                    ),
                    errorWidget: (_, e, o) => CircleAvatar(
                      radius: 16,
                      backgroundColor: AppColors.primaryClr,
                      child: Text(
                        "!",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                    ),
                    imageBuilder: (_, img) => CircleAvatar(
                        radius: 16,
                        backgroundColor: AppColors.darkGryClr,
                        backgroundImage: img),
                  )),
            ),
            Spacing.x(3),
            Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    authCont.getUserMoreInfo?.data.name ?? "",
                    style: textTheme.bodyMedium,
                  ),
                  Spacing.y(0.1),
                  Row(
                    children: [
                      Text(
                       authCont.isOnline.value ? "online" : "offline",
                        style: textTheme.bodySmall,
                      ),
                     authCont.isOnline.value
                          ? Padding(
                              padding: EdgeInsets.only(
                                  left: SizeConfig.widthMultiplier * 1),
                              child: CircleAvatar(
                                radius: 4,
                                backgroundColor: Colors.green,
                              ),
                            )
                          : const SizedBox()
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            Transform.scale(
              scaleX: 0.8,
              scaleY: 0.8,
              child: Obx(
                () => CupertinoSwitch(
                  trackColor: Colors.grey,
                  activeColor: AppColors.primaryClr,
                  thumbColor: AppColors.whiteClr,
                  value: authCont.isOnline.value,
                  onChanged: (bool value) {
                    authCont.isOnline.value = value;
                    cont.updateStatus();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
