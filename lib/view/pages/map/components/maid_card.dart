import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/icons.dart';
import '../../../../utils/size_config.dart';
import '../../../../utils/spacing.dart';


class MaidCard extends StatelessWidget {
  const MaidCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme=Theme.of(context).textTheme;
    return Container(
      width: SizeConfig.widthMultiplier * 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.darkGryClr,
      ),
      margin: EdgeInsets.symmetric(
          horizontal: SizeConfig.widthMultiplier * 2.5),
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.widthMultiplier * 4,
          vertical: SizeConfig.heightMultiplier * 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${tr("Estimate of")} João's ${tr("arrival")}",
                style: textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              Text(
                "20/08/2023",
                style: textTheme.bodyMedium,
              ),
            ],
          ),
          Spacing.y(2),
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.black,
                child: Image.asset(AppIcons.add,
                  color: Colors.green,
                  height: SizeConfig.imageSizeMultiplier*6,
                  width: SizeConfig.imageSizeMultiplier*6,
                ),
              ),
              Spacing.x(4),
              Text(
                "Maid",
                style: textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.w600),
              ).tr(),
              Text(
                " - 05:30",
                style: textTheme.bodyMedium,
              ),
            ],
          )
        ],
      ),
    );
  }
}
