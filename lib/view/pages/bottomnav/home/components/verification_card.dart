import 'package:doss/constants/cont.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../constants/colors.dart';
import '../../../../../utils/size_config.dart';

class VerificationCard extends StatelessWidget {
  final String icon;
  final String title;
  final bool isVerification;
  const VerificationCard(
      {Key? key,
      required this.icon,
      required this.title,
      this.isVerification = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      height: SizeConfig.heightMultiplier * 13,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.darkGryClr,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.widthMultiplier * 5.0,
            vertical: SizeConfig.heightMultiplier * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black,
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Image.asset(
                  icon,
                  height: SizeConfig.imageSizeMultiplier * 5,
                  width: SizeConfig.imageSizeMultiplier * 5,
                ),
              ),
            ),
            Row(
              children: [
                Text(
                  tr(title),
                  style: textTheme.headlineSmall!
                      .copyWith(fontSize: SizeConfig.textMultiplier * 2),
                ),
                isVerification
                    ? Obx(
                        () => authCont.isNewVerification.value
                            ? Padding(
                                padding: EdgeInsets.only(
                                    left: SizeConfig.widthMultiplier * 1),
                                child: CircleAvatar(
                                  radius: 4,
                                  backgroundColor: Colors.green,
                                ),
                              )
                            : const SizedBox(),
                      )
                    : const SizedBox()
              ],
            )
          ],
        ),
      ),
    );
  }
}
