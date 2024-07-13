import 'package:doss/utils/size_config.dart';
import 'package:flutter/material.dart';
class Spacing {
  static Widget x(double val) {
    return SizedBox(width: SizeConfig.widthMultiplier * val);
  }

  static Widget y(double val) {
    return SizedBox(height: SizeConfig.heightMultiplier * val);
  }
}
