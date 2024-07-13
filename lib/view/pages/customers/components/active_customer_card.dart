import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';
import '../../../../utils/size_config.dart';
import '../../../../utils/spacing.dart';


class ActiveCustomerCard extends StatelessWidget {
  const ActiveCustomerCard({Key? key, required this.value}) : super(key: key);
final int value;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      height: SizeConfig.heightMultiplier*16,
      width: SizeConfig.widthMultiplier*50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.darkGryClr
      ),
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.widthMultiplier*5,
        vertical: SizeConfig.heightMultiplier*2.5,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value.toString(),
            style: textTheme.headlineLarge,
          ),
          Spacing.y(1),
          Text("Active customers",
            style: textTheme.bodySmall,
          ).tr(),
        ],
      ),
    );
  }
}
