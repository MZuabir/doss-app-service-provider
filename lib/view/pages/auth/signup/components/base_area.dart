import 'package:doss/constants/colors.dart';
import 'package:doss/constants/cont.dart';
import 'package:doss/controllers/base_area.dart';
import 'package:doss/view/widgets/custom_button.dart';
import 'package:doss/view/widgets/loading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:get/get.dart';

import '../../../../../controllers/sign_up.dart';
import '../../../../../utils/size_config.dart';
import '../../../../../utils/spacing.dart';


class BaseArea extends StatefulWidget {

   const BaseArea({    Key? key,
     this.isEdit=false,
  }) : super(key: key);
  final bool isEdit;

  @override
  State<BaseArea> createState() => _BaseAreaState();
}

class _BaseAreaState extends State<BaseArea> {
  final cont=Get.put(BaseAreaCont());
double lowerValue=30;
  String? _upperValue;
  String? _lowerValue;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Obx(
      ()=> ShowLoading(
        inAsyncCall: authCont.isLoading.value,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text("Base Area",
                style: textTheme.headlineMedium,
              ).tr(),
            ),
            Spacing.y(3),
            Image.asset("assets/images/area.png",
              height: SizeConfig.imageSizeMultiplier*78,
              width: SizeConfig.imageSizeMultiplier*78,
            ),
            Spacing.y(3),
            Container(
              height: SizeConfig.heightMultiplier*20,
              width: SizeConfig.widthMultiplier*100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.darkGryClr
              ),
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier*3,vertical: SizeConfig.heightMultiplier*3),
              child: Column(
                children: [
                  Spacing.y(2),
                  FlutterSlider(

                    tooltip: FlutterSliderTooltip(

                        textStyle: textTheme.bodyMedium,
                        format: (value) {
                           '$value km';
                           cont.area =double.parse(value).toInt();
                           // cont.area =int.parse(value).toDouble();
                           lowerValue=double.parse(cont.area.toString());

                          return value ;
                        },
                        boxStyle:FlutterSliderTooltipBox(

                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(
                                    color: AppColors.darkGryClr,
                                    width: 0
                                )
                            )
                        ),
                        alwaysShowTooltip: true,
                        positionOffset: FlutterSliderTooltipPositionOffset(
                          right: 0,top: -30,

                        )
                    ),
                    decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          width: 0.5,
                            color: AppColors.primaryClr
                        )
                    ),
                    values:  [lowerValue, 420],
                    rangeSlider: false,
                    // rtl: true,
                    // centeredOrigin: true,
                    visibleTouchArea: true,
                    selectByTap: true,
                    handlerWidth: 10,
                    trackBar: FlutterSliderTrackBar(
                        inactiveTrackBarHeight: 6,
                        activeTrackBarHeight: 6,inactiveTrackBar: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.darkGryClr
                    ) ,
                        activeTrackBar: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.primaryClr
                        )
                    ),
                    handler: FlutterSliderHandler(
                        opacity:1,
                        child: const SizedBox.shrink()
                    ),

                    max: 500,
                    min: 0,
                    onDragCompleted: (handlerIndex, lowerValue, upperValue) {
                      _lowerValue = lowerValue;
                      _upperValue = upperValue;
                      setState(() {});
                    },
                  ),
                  Spacing.y(2),
                  Text("Remember: The larger the coverage area, the more customers will appear, but you will need to deal with coverage within that area if requested.",
                    style: textTheme.bodySmall,
                  ).tr(),
                ],
              ),
            ),
            Spacing.y(3),
            CustomButton(
                title: "Next", onTap: () {
               cont.postBaseArea();
            })

          ],
        ),
      ),
    );
  }
}
