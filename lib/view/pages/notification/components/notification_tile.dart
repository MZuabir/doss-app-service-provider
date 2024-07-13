import 'package:doss/constants/colors.dart';
import 'package:doss/utils/size_config.dart';
import 'package:doss/utils/spacing.dart';
import 'package:flutter/material.dart';


class NotificationTile extends StatelessWidget {
  final String title;
  final String date;
  const NotificationTile({Key? key, required this.title, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      width: SizeConfig.widthMultiplier*100,
      margin: EdgeInsets.only(bottom: SizeConfig.heightMultiplier*2),
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier*6,vertical: SizeConfig.heightMultiplier*2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.tileClr,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,style: textTheme.labelMedium!.copyWith(color: AppColors.whiteClr),),
          Spacing.y(2),
          Align(
            alignment: Alignment.topRight,
              child
              : Text(date,style: textTheme.bodySmall!.copyWith(color: AppColors.primaryClr),)),
        ],
      ),
    );
  }
}
