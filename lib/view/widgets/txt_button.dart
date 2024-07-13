import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../utils/size_config.dart';


class CustomTextBtn extends StatelessWidget {
  final Function()? onTap;
  final String title;
  const CustomTextBtn({Key? key, this.onTap, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onTap,
        child: Text(
            tr(title),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: SizeConfig.textMultiplier * 2.2,
          ),
        ),);
  }
}
