import 'package:doss/constants/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

showCustomSnackbar(bool isError, String text) {
  return showTopSnackBar(
    Overlay.of(Get.overlayContext!),
    animationDuration: const Duration(seconds: 1),
    isError
        ? CustomSnackBar.error(
      message: tr(text),
      maxLines: 3,
      textStyle: const TextStyle(
          fontWeight: FontWeight.w600, color: Colors.white),
      backgroundColor: Colors.red,
    )
        : CustomSnackBar.success(
      message: tr(text),
      maxLines: 3,
      textStyle: const TextStyle(
          fontWeight: FontWeight.w600, color: Colors.black),
      backgroundColor: AppColors.primaryClr,
    ),
  );
  // return ScaffoldMessenger.of(Get.overlayContext!).showSnackBar(SnackBar(
  //   behavior: SnackBarBehavior.floating,
  //   padding: EdgeInsets.only(bottom: 0),
  //   backgroundColor: Colors.transparent,
  //   elevation: 0,
  //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
  //   content: Container(
  //     width: SizeConfig.widthMultiplier*100,
  //     decoration: BoxDecoration(
  //         color: Colors.grey.shade900,
  //         borderRadius: BorderRadius.circular(8)),
  //     child: Padding(
  //       padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier*5, vertical: SizeConfig.heightMultiplier*1.5),
  //       child: Row(
  //         children: [
  //           !isError
  //               ? const SizedBox()
  //               : Icon(isError ? Icons.error : Icons.done,
  //                   color: Colors.white),
  //           SizedBox(width: !isError ? 0 : SizeConfig.widthMultiplier*5),
  //           SizedBox(
  //             width: SizeConfig.widthMultiplier*65,
  //             child: Text(
  //               text,
  //               style: const TextStyle(fontFamily: 'Poppins'),
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   )));
}