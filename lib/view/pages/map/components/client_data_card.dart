import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/colors.dart';
import '../../../../utils/size_config.dart';
import '../../../../utils/spacing.dart';
import 'custom_map_button.dart';

class ClientDataCard extends StatelessWidget {
  const ClientDataCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return
    Container(
      width: SizeConfig.widthMultiplier * 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.darkGryClr,
      ),
      margin: EdgeInsets.symmetric(
          horizontal: SizeConfig.widthMultiplier * 2.5),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.widthMultiplier * 4,
                vertical: SizeConfig.heightMultiplier * 3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${tr("Customers")} data",
                  style: textTheme.bodyMedium!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                Spacing.y(2),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: AppColors.darkGryClr,
                      backgroundImage: const NetworkImage(
                          "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                    ),
                    Spacing.x(3),
                    Text(
                      "Joao Alves",
                      style: textTheme.bodySmall!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Spacing.y(2),
                Text(
                  "Watchman's vehicle",
                  style: textTheme.bodyMedium!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                Spacing.y(2),
                Text(
                  "Fiat Argo Drive 1.0 - Silver - XYZ0000",
                  style: textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          Container(
            height: SizeConfig.heightMultiplier * 20,
            width: SizeConfig.widthMultiplier * 100,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                )),
            child: Image.network(
                "https://cdni.autocarindia.com/utils/imageresizer.ashx?n=https://cms.haymarketindia.net/model/uploads/modelimages/Hyundai-Grand-i10-Nios-200120231541.jpg&w=872&h=578&q=75&c=1"),
          ),
        ],
      ),
    );
  }
}
