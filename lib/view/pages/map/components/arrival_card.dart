import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/icons.dart';
import '../../../../utils/size_config.dart';
import '../../../../utils/spacing.dart';

class ArrivalCard extends StatelessWidget {
  const ArrivalCard({Key? key}) : super(key: key);

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
          Text(
            "${tr("Estimate of")} João's ${tr("arrival")}",
            style: textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.w600),
          ),
          Spacing.y(2),
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.black,
                child: Image.asset(AppIcons.location,
                  height: SizeConfig.imageSizeMultiplier*6,
                  width: SizeConfig.imageSizeMultiplier*6,
                ),
              ),
              Spacing.x(4),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Distance to location",
                    style: textTheme.bodySmall,
                  ).tr(),
                  Text(
                    "1.2 km",
                    style: textTheme.bodyMedium!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ],),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Approx.",
                    style: textTheme.bodySmall,
                  ),
                  Text(
                    "6 ${tr("minutes")}",
                    style: textTheme.bodyMedium!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ],),
            ],
          )
        ],
      ),
    );
  }
}
