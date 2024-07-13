import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doss/constants/cont.dart';
import 'package:doss/utils/size_config.dart';
import 'package:doss/utils/spacing.dart';
import 'package:doss/view/pages/account%20detail/account_detail.dart';
import 'package:doss/view/pages/customers/customers.dart';
import 'package:doss/view/pages/emergency/emergency_customers/emergency_customers.dart';
import 'package:doss/view/pages/vehicles/vehicles.dart';
import 'package:doss/view/widgets/background.dart';
import 'package:doss/view/widgets/custom_appbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants/colors.dart';
import 'components/profile_card.dart';
import 'components/profile_tile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<String> cardTitles = [
    "Customers",
    "Vehicles",
  ];
  List<String> tileTitles = [
    "Account",
    "Privacy and Accessibility",
    "Rate app",
    "Report a problem in the app",
    "Help",
    "Logout"
  ];
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Background(
          child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 2.5),
        child: Column(
          children: [
            Spacing.y(7),
            CustomAppbar(
              onBackBtnTap: ()=>authCont.bnbIndex.value=0,
              title: 'Profile'),
            Spacing.y(4),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Spacing.y(3),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 30,
                      child: Obx(
                        () => CachedNetworkImage(
                              imageUrl:
                                  authCont.getUserMoreInfo?.data.photoUrl ??
                                      "",
                              placeholder: (_, p_o) => CircleAvatar(
                                radius: 29,
                                backgroundColor: AppColors.darkGryClr,
                                child: CupertinoActivityIndicator(
                                    radius: 8, color: Colors.white),
                              ),
                              errorWidget: (_, e, o) => CircleAvatar(
                                radius: 29,
                                backgroundColor: AppColors.primaryClr,
                                child: Text(
                                  "!",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              imageBuilder: (_, img) => CircleAvatar(
                                  radius: 29,
                                  backgroundColor: AppColors.darkGryClr,
                                  backgroundImage: img),
                            ),
                      ),
                    ),
                    Spacing.y(3),
                    Obx(
                      () => Text(
                        authCont.getUserMoreInfo?.data.name ?? "",
                        textAlign: TextAlign.center,
                        style: textTheme.headlineMedium!
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                    ),
                    Spacing.y(5),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 13,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: cardTitles.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              if (index == 0) {
                                Get.to(
                                  () => Customers(),
                                  transition: Transition.rightToLeft,
                                );
                              } else {
                                Get.to(
                                  () => const VehiclesPage(),
                                  transition: Transition.rightToLeft,
                                );
                              }
                            },
                            child: ProfileCard(
                              title: cardTitles[index],
                            ),
                          );
                        },
                      ),
                    ),
                    Spacing.y(2.5),
                    ...List.generate(
                        tileTitles.length,
                        (index) => ProfileTile(
                              title: tileTitles[index],
                              onTap: () {
                                if (index == 0) {
                                  Get.to(() => AccountDetailPage());
                                }
                                if (index == tileTitles.length - 1) {
                                  log("TAPPED");
                                  authCont.signout();
                                }
                              },
                            )),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
