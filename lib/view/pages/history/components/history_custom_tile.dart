import 'package:doss/models/history.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';
import '../../../../utils/size_config.dart';
import '../../../../utils/spacing.dart';
import 'custom_button.dart';

class HistoryCustomTile extends StatelessWidget {
  const HistoryCustomTile({Key? key, required this.model}) : super(key: key);
  final HistoryItem model;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      width: SizeConfig.widthMultiplier * 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.tileClr,
      ),
      margin: EdgeInsets.only(bottom: SizeConfig.heightMultiplier * 2.5),
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.widthMultiplier * 4,
          vertical: SizeConfig.heightMultiplier * 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${tr("Today")} 10:20 - 10:40",
            style: textTheme.headlineSmall,
          ),
          Spacing.y(3),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
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
                style: textTheme.bodyMedium,
              ),
              const Spacer(),
              const HistoryCustomButton(),
            ],
          ),
        ],
      ),
    );
  }
}
