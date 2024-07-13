import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../constants/colors.dart';
import '../../../../utils/size_config.dart';

class HistoryCustomButton extends StatelessWidget {
  const HistoryCustomButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: AppColors.greyLightClr
      ),
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier*6,vertical: SizeConfig.heightMultiplier*0.5),
      child: Text(
        "Verification",
        style: textTheme.bodySmall!.copyWith(color: Colors.black,fontWeight: FontWeight.w500),
      ).tr(),
    );
  }
}