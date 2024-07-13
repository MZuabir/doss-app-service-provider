import 'package:doss/constants/icons.dart';
import 'package:doss/view/widgets/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../constants/colors.dart';
import '../../../../../utils/size_config.dart';
import '../../../../../utils/spacing.dart';
import '../../../../bottom sheets/custom_btm_sheet.dart';
import '../../../chat/chat.dart';
import '../../../map/map.dart';


class RoofCard extends StatefulWidget {
  const RoofCard({Key? key}) : super(key: key);

  @override
  State<RoofCard> createState() => _RoofCardState();
}
class _RoofCardState extends State<RoofCard> {



  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.tileClr,
      ),
      margin: EdgeInsets.only(
          bottom: SizeConfig.heightMultiplier*4
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              ),
              color: AppColors.darkGryClr,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.widthMultiplier*5,
              vertical: SizeConfig.heightMultiplier*1.5,),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: AppColors.darkGryClr,
                      backgroundImage: const NetworkImage("https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                    ),
                    Spacing.x(3),
                    Text(
                      "Joao Alves",
                      style: textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                    Text(
                      "Today",
                      style: textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600),
                    ).tr(),
                    Spacing.x(2),
                    Text(
                      "at 08:20",
                      style: textTheme.bodySmall,
                    ),
                  ],
                ),
                Spacing.y(2),
                Row(
                  children: [
                    Text(
                      "1.6 km  ",
                      style: textTheme.bodySmall!.copyWith(color: AppColors.primaryClr),
                    ),
                    Text(
                      "from the residence",
                      style: textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600),
                    ).tr(),
                    const Spacer(),
                    Text(
                      "Arrival approx",
                      style: textTheme.bodySmall,
                    ).tr(),
                    Spacing.x(2),
                    Text(
                      ". 6 "+tr("minutes"),
                      style: textTheme.bodySmall!.copyWith(color: AppColors.primaryClr),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.widthMultiplier*5,
              vertical: SizeConfig.heightMultiplier*2,),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Address",
                      style: textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
                    ).tr(),
                    Text(
                      "View on map",
                      style: textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600,color: AppColors.primaryClr),
                    ).tr(),
                  ],
                ),
                Spacing.y(2),
                Text("Avenida Anchieta, 200 - Campinas - SP - CEP: 13.015-904",
                  style: textTheme.bodyMedium,),
                Spacing.y(2),
                Center(
                  child: CustomButton(
                      height: SizeConfig.heightMultiplier*5,
                      title: "Make coverage", onTap: (){
                    _showBottomSheet(context);
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return   CustomBottomSheet (icon: AppIcons.warning,onTap: (){
          Get.back();
          Get.to(()=> const MapPage(),
          transition: Transition.rightToLeft,
          );
        },
          btnTitle: 'Yes, I will Cover',
        title: "Proceed with coverage?",
        ); // Use the separate BottomSheet widget
      },
    );
  }
}