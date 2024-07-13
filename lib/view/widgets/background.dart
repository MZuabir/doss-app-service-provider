import 'package:doss/constants/colors.dart';
import 'package:flutter/material.dart';
import '../../../utils/size_config.dart';

class Background extends StatefulWidget {
  const Background({super.key, required this.child});
  final Widget child;
  @override
  State<Background> createState() => _BackgroundState();
}

class _BackgroundState extends State<Background> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.heightMultiplier * 100,
      width: SizeConfig.widthMultiplier * 100,
      decoration:  BoxDecoration(
          gradient: AppColors.background,
      ),
      child: widget.child,
    );
  }
}
