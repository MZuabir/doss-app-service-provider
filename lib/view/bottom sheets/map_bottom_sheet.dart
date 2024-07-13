import 'package:doss/view/pages/map/components/arrival_card.dart';
import 'package:doss/view/pages/map/components/custom_map_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:doss/constants/colors.dart';
import 'package:doss/utils/size_config.dart';
import 'package:doss/utils/spacing.dart';
import 'package:get/get.dart';

import '../pages/map/components/client_data_card.dart';
import '../pages/map/components/maid_card.dart';

class CustomMapBottomSheet extends StatelessWidget {
  final String icon;
  final Function()? onTap;
  const CustomMapBottomSheet(
      {super.key,
      required this.icon,
      this.onTap,
      });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      height: SizeConfig.heightMultiplier * 95,
      color: AppColors.greyLightClr,
      child: Column(
        children: [
          Spacing.y(2),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Spacing.y(2),
                  Container(
                    height: SizeConfig.heightMultiplier * 9,
                    width: SizeConfig.widthMultiplier * 100,
                    color: AppColors.darkGryClr.withOpacity(0.5),
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.widthMultiplier * 2.3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "John ${tr("is on his way")}",
                          style: textTheme.bodySmall,
                        ),
                        CustomMapButton(
                          title: "Return To Map",
                          onTap: () {
                            Get.back();
                          },
                        )
                      ],
                    ),
                  ),
                  Spacing.y(2.5),
                  const ClientDataCard(),
                  Spacing.y(2.5),
                  const ArrivalCard(),
                  Spacing.y(2.5),
                  const MaidCard(),
                  Spacing.y(3),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
