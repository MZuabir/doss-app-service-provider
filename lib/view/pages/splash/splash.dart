import 'dart:async';

import 'package:doss/constants/cont.dart';
import 'package:doss/constants/local_db.dart';
import 'package:doss/controllers/status.dart';
import 'package:doss/utils/spacing.dart';
import 'package:doss/view/pages/access/access.dart';
import 'package:doss/view/pages/bottomnav/bottom_nav_bar.dart';
import 'package:doss/view/widgets/background.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../controllers/auth.dart';
import '../../../utils/size_config.dart';
import '../auth/signup/signup_onboarding.dart';
import '../onboarding/onboarding.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      final prefs = await SharedPreferences.getInstance();
      authCont.accessToken.value =
          prefs.getString(LocalDBconstants.accesstoken) ?? "";

      if (authCont.accessToken.value != "" &&
          authCont.accessToken.value.isNotEmpty) {
        await authCont.refreshToken();
        await authCont.getUserMoreInfoFromBackend();
         Timer.periodic(const Duration(minutes: 2),
        (timer) async => await authCont.refreshToken());
        _navigateToNextScreen();
      } else {
        await Future.delayed(const Duration(seconds: 4));
        Get.off(() => const OnBoarding(), transition: Transition.rightToLeft);
      }
    });
   
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    await authCont.checkStatus();
    if (authCont.getStatus?.data?.completedRegistration == true) {
      Get.off(() => const BottomNavPage(), transition: Transition.rightToLeft);
    } else {
      // Get.off(() => const SignUpOnBoardingPage(),transition: Transition.rightToLeft);
      Get.off(() => const OnBoarding(), transition: Transition.rightToLeft);
    }
    print(authCont.getStatus?.data?.completedRegistration);

    // Get.off(()=> const AccessPage(),);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Background(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "DossApp",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: SizeConfig.textMultiplier * 7,
                fontWeight: FontWeight.w600,
                letterSpacing: 3,
              ),
            ),
            Spacing.y(2),
            Text(
              "Security and tranquility, always by your side!",
              textAlign: TextAlign.center,
              style: textTheme.bodySmall,
            ).tr(),
          ],
        ),
      ),
    );
  }
}
