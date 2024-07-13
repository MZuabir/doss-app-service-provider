import 'dart:developer';

import 'package:doss/constants/colors.dart';
import 'package:doss/constants/icons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/languages.dart';
import '../../constants/local_db.dart';
import '../../controllers/auth.dart';
import '../../utils/size_config.dart';

class SelectLanguageBS extends GetWidget<AuthCont> {
  SelectLanguageBS({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    log(controller.userLanguage.value.toString());
    return Container(
      height: SizeConfig.heightMultiplier * 26,
      width: SizeConfig.widthMultiplier * 100,
      decoration: BoxDecoration(
          color: AppColors.darkGryClr,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.widthMultiplier * 5,
          vertical: SizeConfig.heightMultiplier * 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select language',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: SizeConfig.heightMultiplier * 2),
          ListView.builder(
              itemCount: languages.length,
              shrinkWrap: true,
              itemBuilder: (_, i) => Obx(
                    () => ListTile(
                  onTap: () => _onListTap(context, i),
                  trailing: controller.userLanguage.value == languages[i]
                      ? Icon(Icons.done, color: Colors.white)
                      : null,
                  leading: Image.asset(
                    i == 0
                        ? AppIcons.flagUK
                        : AppIcons.flagBrazil,
                    height: SizeConfig.heightMultiplier * 4,
                  ),
                  title: Text(
                    languages[i],
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ))
        ],
      ),
    );
  }

  _onListTap(BuildContext context, int index) async {
    final prefs = await SharedPreferences.getInstance();
    if (index == 0) {
      Get.updateLocale(const Locale("en"));
      context.locale = const Locale("en", "US");
      controller.userLanguage.value = 'English';
      prefs.setString(LocalDBconstants.appLanguage, languages[0]);
    }
    if (index == 1) {
      Get.updateLocale(const Locale("pt"));
      context.locale = const Locale("pt", "BR");
      controller.userLanguage.value = 'Portugese';
      prefs.setString(LocalDBconstants.appLanguage, languages[1]);
     
    }
    Get.back();
  }
}
