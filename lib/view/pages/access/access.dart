import 'dart:developer';

import 'package:doss/constants/icons.dart';
import 'package:doss/controllers/auth.dart';
import 'package:doss/utils/size_config.dart';
import 'package:doss/view/widgets/background.dart';
import 'package:doss/view/widgets/custom_button.dart';
import 'package:doss/view/widgets/loading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/spacing.dart';
import '../../widgets/lang_btn.dart';

class AccessPage extends StatefulWidget {
  const AccessPage({Key? key}) : super(key: key);

  @override
  State<AccessPage> createState() => _AccessPageState();
}

class _AccessPageState extends State<AccessPage> {
  List<String> icon=[
    AppIcons.faceBook,
    AppIcons.google,
    AppIcons.apple,
  ];
  final cont=Get.put(AuthCont());
  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context).textTheme;
    return  Obx(
      ()=> ShowLoading(
        inAsyncCall: cont.isLoading.value,
        child: Scaffold(
          body: Background(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal:SizeConfig.widthMultiplier*2.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacing.y(7),
                  Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding:  EdgeInsets.only(right: SizeConfig.widthMultiplier*5),
                        child: const SelectLangButton(),
                      )),
                  Spacer(),
                  Text(
                    "Welcome to)!",
                    textAlign: TextAlign.center,
                    style: textTheme.bodyLarge,
                  ).tr(),
                  Spacing.y(1),
                  Text(
                    "DossApp",
                    textAlign: TextAlign.center,
                    style:TextStyle(
                      color: Colors.white,
                      fontSize: SizeConfig.textMultiplier*7,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 3,
                    ),
                  ),
                  Spacing.y(5),
                  CustomButton(
                      title: "To enter",
                      onTap: () async{
                       await cont.authorization();
                      //  cont.refreshToken();
                      }
                  ),
                  Spacing.y(9),
                  Spacer(),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
