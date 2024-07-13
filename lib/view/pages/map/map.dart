import 'dart:ui';

import 'package:doss/constants/colors.dart';
import 'package:doss/utils/size_config.dart';
import 'package:doss/utils/spacing.dart';
import 'package:doss/view/widgets/background.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../constants/icons.dart';
import '../../bottom sheets/map_bottom_sheet.dart';

class MapPage extends StatelessWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Background(
        child: Stack(
          children: [
            Column(
              children: [
                Spacing.y(5),
                Container(
                  height: SizeConfig.heightMultiplier * 7,
                  color: AppColors.tileClr,
                  child: Center(
                    child: Text(
                      "Ongoing coverage",
                      style: textTheme.bodyMedium,
                    ).tr(),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              child: Column(
                children: [
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 6,
                    width: SizeConfig.widthMultiplier * 100,
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                        child: Container(
                          color: Colors.blueGrey.withOpacity(0.1),
                          child: Center(
                            child: Container(
                              height: SizeConfig.heightMultiplier * 0.8,
                              width: SizeConfig.widthMultiplier * 35,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 10,
                    width: SizeConfig.widthMultiplier * 100,
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                        child: Container(
                            color: Colors.grey.withOpacity(0.1),
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.widthMultiplier * 2.5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "John ${tr("is on his way")}",
                                  style: textTheme.bodySmall!
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    _showBottomSheet(context);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: AppColors.primaryClr),
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            SizeConfig.widthMultiplier * 8,
                                        vertical:
                                            SizeConfig.heightMultiplier * 0.7),
                                    child: Text(
                                      "see details",
                                      style: textTheme.bodySmall!.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                    ).tr(),
                                  ),
                                )
                              ],
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return   CustomMapBottomSheet(icon: AppIcons.warning,onTap: (){
          // Get.to(()=> const MapPage(),
          //   transition: Transition.rightToLeft,
          // );
        },
        ); // Use the separate BottomSheet widget
      },
    );
  }

}
