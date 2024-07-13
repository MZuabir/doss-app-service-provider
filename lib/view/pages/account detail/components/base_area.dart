
import 'package:doss/constants/colors.dart';
import 'package:doss/controllers/account_detail.dart';
import 'package:doss/view/widgets/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:get/get.dart';

import '../../../../../utils/size_config.dart';
import '../../../../../utils/spacing.dart';

class AdBaseAreaWidget extends StatefulWidget {
  const AdBaseAreaWidget({
    Key? key,
    this.isEdit = false,
  }) : super(key: key);
  final bool isEdit;

  @override
  State<AdBaseAreaWidget> createState() => _AdBaseAreaWidgetState();
}

class _AdBaseAreaWidgetState extends State<AdBaseAreaWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool isExpanded = false;
  final cont = Get.find<AccountDetailCont>();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  void _toggleExpand() {
    FocusScope.of(context).unfocus();
    setState(() {
      isExpanded = !isExpanded;
      if (isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  double lowerValue = 30;
  String? _upperValue;
  String? _lowerValue;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: _toggleExpand,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.darkGryClr,
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.widthMultiplier * 5,
                  vertical: SizeConfig.heightMultiplier * 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Base Area',
                    style: textTheme.bodyLarge,
                  ).tr(),
                  CircleAvatar(
                    radius: SizeConfig.widthMultiplier * 3,
                    backgroundColor: Colors.white12,
                    child: Icon(
                      isExpanded
                          ? Icons.arrow_drop_up_sharp
                          : Icons.arrow_drop_down,
                      color: isExpanded ? AppColors.primaryClr : Colors.grey,
                    ),
                  )
                ],
              ),
            ),
            AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return ClipRRect(
                    child: Align(
                      alignment: Alignment.topCenter,
                      heightFactor: _animationController.value,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.widthMultiplier * 5),
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/images/area.png",
                              height: SizeConfig.imageSizeMultiplier * 78,
                              width: SizeConfig.imageSizeMultiplier * 78,
                            ),
                            Spacing.y(3),
                            Container(
                              height: SizeConfig.heightMultiplier * 20,
                              width: SizeConfig.widthMultiplier * 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.darkGryClr),
                              padding: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.widthMultiplier * 3,
                                  vertical: SizeConfig.heightMultiplier * 3),
                              child: Column(
                                children: [
                                  Spacing.y(2),
                                  FlutterSlider(
                                    
                                    tooltip: FlutterSliderTooltip(
                                        textStyle: textTheme.bodyMedium,
                                        format: (value) {
                                          '$value km';
                                          cont.area.value =
                                              double.parse(value).toInt();
                                          // cont.area =int.parse(value).toDouble();
                                          lowerValue = double.parse(
                                              cont.area.value.toString());

                                          return value;
                                        },
                                        boxStyle: FlutterSliderTooltipBox(
                                            decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                border: Border.all(
                                                    color: AppColors.darkGryClr,
                                                    width: 0))),
                                        alwaysShowTooltip: true,
                                        positionOffset:
                                            FlutterSliderTooltipPositionOffset(
                                          right: 0,
                                          top: -30,
                                        )),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(
                                            width: 0.5,
                                            color: AppColors.primaryClr)),
                                    values: [cont.area.value.toDouble(), 420],
                                    rangeSlider: false,
                                    // rtl: true,
                                    // centeredOrigin: true,
                                    visibleTouchArea: true,
                                    selectByTap: true,
                                    handlerWidth: 10,
                                    trackBar: FlutterSliderTrackBar(
                                        inactiveTrackBarHeight: 6,
                                        activeTrackBarHeight: 6,
                                        inactiveTrackBar: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: AppColors.darkGryClr),
                                        activeTrackBar: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: AppColors.primaryClr)),
                                    handler: FlutterSliderHandler(
                                        opacity: 1,
                                        child: const SizedBox.shrink()),

                                    max: 500,
                                    min: 0,
                                    onDragCompleted:
                                        (handlerIndex, lowerValue, upperValue) {
                                      _lowerValue = lowerValue;
                                      _upperValue = upperValue;
                                      setState(() {});
                                    },
                                  ),
                                  Spacing.y(2),
                                  Text(
                                    "Remember: The larger the coverage area, the more customers will appear, but you will need to deal with coverage within that area if requested.",
                                    style: textTheme.bodySmall,
                                  ).tr(),
                                ],
                              ),
                            ),
                            Spacing.y(3),
                            CustomButton(
                                title: "Update",
                                onTap: () {
                                  cont.updateUserDetails();
                                  //  cont.postAdBaseAreaWidget();
                                }),
                                  Spacing.y(3),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
