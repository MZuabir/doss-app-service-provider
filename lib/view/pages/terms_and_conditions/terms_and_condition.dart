import 'package:doss/constants/icons.dart';
import 'package:doss/utils/size_config.dart';
import 'package:doss/utils/spacing.dart';
import 'package:doss/view/widgets/background.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class TermAndConditionsPage extends StatelessWidget {
  const TermAndConditionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme=Theme.of(context).textTheme;
    return Scaffold(
      body: Background(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier*2.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacing.y(7),
              GestureDetector(
                onTap: (){
                  Get.back();
                },
                child: Align(
                  alignment: Alignment.topRight,
                  child: Image.asset(AppIcons.cancel,
                  height: SizeConfig.imageSizeMultiplier*9,
                  width: SizeConfig.imageSizeMultiplier*9,
                  ),
                ),
              ),
              Spacing.y(2),
              Text("Terms of Use and Privacy Policies",
              style: textTheme.headlineSmall,
              ).tr(),
              Spacing.y(2),
              Text("Welcome to our platform's Terms of Use and Privacy Policy! Here you will find important information about our privacy and security policies, as well as the terms that govern the use of our platform. By using our platform, you agree to our Terms of Use and Privacy Policy, so read them carefully before proceeding.",
              style: textTheme.bodySmall,
              ).tr(),
              Spacing.y(2),
              Text("Our Terms of Use establish the conditions for the use of our platform, including the rules for using our services and resources, as well as the prohibition of inappropriate and illegal conduct. Additionally, our Terms of Use include information about our intellectual property rights and how they apply to our platform.",
                style: textTheme.bodySmall,
              ).tr(),
              Spacing.y(2),
              Text("Our Privacy Policy describes how we collect, use and protect your personal information. This includes information about what types of information we collect, how we use that information, and with whom we share it. We strive to keep your personal information safe and secure at all times.",
                style: textTheme.bodySmall,
              ).tr(),
              Spacing.y(2),
              Text("By using our platform, you agree to comply with our Terms of Use and Privacy Policy. If you have any questions about our Terms of Use or Privacy Policy, please contact us. We are here to help you understand our policies and how they apply to your use of our platform.",
                style: textTheme.bodySmall,
              ).tr(),

            ],
          ),
        ),
      ),
    );
  }
}
