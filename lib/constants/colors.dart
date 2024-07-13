import 'package:flutter/material.dart';

abstract class AppColors {
  static Color fieldClr=const Color(0xffE4E4E4);
  static Color primaryClr = const Color(0xffFFC300);
  static Color textClr = const Color(0xff04104A);
  static Color textMediumClr = const Color(0xff535353);
  static Color textLightClr = Colors.black38;
  static Color whiteClr = Colors.white;
  static Color greyClr = const Color(0xff212121);
  static Color greyLightClr = const Color(0xffEEEEEE);
  static Color darkGryClr = const Color(0xff212121);
  static Color redClr = const Color(0xffFF5A5A);
  static Color tileClr = const Color(0xff1A1A1A);
  static Gradient background = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xff03040D), Color(0xff1F1F1F)],
  );
}
