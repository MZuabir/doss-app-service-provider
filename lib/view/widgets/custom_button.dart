import 'package:doss/constants/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../utils/size_config.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    Key? key,
    required this.title,
    required this.onTap,
    this.isLoading = false,
    this.isEnabled = true,
    this.height,
  }) : super(key: key);
  final Function()? onTap;
  final bool isEnabled;
  final String title;
  final double? height;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? SizeConfig.heightMultiplier * 6,
        width: SizeConfig.widthMultiplier * 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: isEnabled ? AppColors.primaryClr : Colors.grey,
        ),
        child: Center(
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.darkGryClr,
                    strokeWidth: 2.5,
                  ),
                )
              : Text(
                  tr(title),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: SizeConfig.textMultiplier * 2.2,
                  ),
                ),
        ),
      ),
    );
  }
}
