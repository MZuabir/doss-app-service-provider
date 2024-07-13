import 'package:doss/constants/cont.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../constants/colors.dart';
import '../../../../utils/size_config.dart';

class EmergencyCustomButton extends StatelessWidget {
  const EmergencyCustomButton({Key? key, required this.phoneNumber})
      : super(key: key);
  final String phoneNumber;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: () =>openDialer(phoneNumber),
      child: Container(
        height: SizeConfig.heightMultiplier * 5.5,
        width: SizeConfig.widthMultiplier * 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: AppColors.primaryClr,
        ),
        child: Center(
            child: Text(
          "To connect",
          style: textTheme.bodyLarge!.copyWith(color: Colors.black),
        ).tr()),
      ),
    );
  }

  void openDialer(String phoneNumber) async {
    authCont.isLoading.value = true;
    final url = 'tel:$phoneNumber';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
    authCont.isLoading.value = false;
  }
}
