import 'package:doss/constants/icons.dart';
import 'package:doss/controllers/verification.dart';
import 'package:doss/models/verification_all.dart';
import 'package:doss/view/pages/chat/chat.dart';
import 'package:doss/view/pages/show%20map/show_map.dart';
import 'package:doss/view/widgets/custom_button.dart';
import 'package:doss/view/widgets/loading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../constants/colors.dart';
import '../../../../../utils/size_config.dart';
import '../../../../../utils/spacing.dart';
import '../../../../bottom sheets/custom_btm_sheet.dart';

class VerificationCard extends StatelessWidget {
  VerificationCard({Key? key, required this.data}) : super(key: key);

  final Verification data;

  final cont = Get.find<VerificationCont>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    String dateTime = cont.formatDateTime(data.when.toString());

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.tileClr,
      ),
      margin: EdgeInsets.only(bottom: SizeConfig.heightMultiplier * 4),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              ),
              color: AppColors.darkGryClr,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.widthMultiplier * 5,
              vertical: SizeConfig.heightMultiplier * 1.5,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          right: SizeConfig.widthMultiplier * 4),
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.white10,
                        backgroundImage: data.residential!.photo == null
                            ? null
                            : NetworkImage(data.residential!.photo!),
                        child: data.residential!.photo == null
                            ? const Icon(
                                CupertinoIcons.person,
                                size: 18,
                                color: Colors.grey,
                              )
                            : null,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.residential!.name.toString(),
                          style: textTheme.bodySmall!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        Spacing.y(.2),
                        Text(
                          dateTime,
                          style: textTheme.labelSmall!
                              .copyWith(color: Colors.grey),
                        ),
                      ],
                    ),

                    // Text(
                    //   "Today",
                    //   style: textTheme.bodySmall!
                    //       .copyWith(fontWeight: FontWeight.w600),
                    // ).tr(),
                    // Spacing.x(2),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.widthMultiplier * 5,
              vertical: SizeConfig.heightMultiplier * 2,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Address",
                      style: textTheme.bodyMedium!
                          .copyWith(fontWeight: FontWeight.w600),
                    ).tr(),
                    InkWell(
                      onTap: () => Get.to(() => ShowOnMapPage(data: data)),
                      child: Text(
                        "View on map",
                        style: textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryClr),
                      ).tr(),
                    ),
                  ],
                ),
                Spacing.y(2),
                Text(
                  "${data.address!.city}, ${data.address!.number} - ${data.address!.state} - ${data.address!.street} - ${data.address!.zipCode}",
                  style: textTheme.bodyMedium,
                ),
                Spacing.y(2),
                Container(
                  color: AppColors.whiteClr,
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.widthMultiplier * 3,
                    vertical: SizeConfig.heightMultiplier * 3,
                  ),
                  child: Center(
                    child: Text(data.message.toString(),
                            style: textTheme.bodyMedium!
                                .copyWith(color: Colors.black))
                        .tr(),
                  ),
                ),
                Spacing.y(3),
                Center(
                  child: CustomButton(
                      height: SizeConfig.heightMultiplier * 5,
                      title: "Check",
                      onTap: () {
                        cont.verificationID.value = data.id!;
                        print(cont.verificationID.value);
                        _showBottomSheet(context, data);
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showBottomSheet(BuildContext context, Verification data) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Obx(
          () => CustomBottomSheet(
            icon: AppIcons.warning,
            Loading: cont.isVerificationLoading.value,
            onTap: () async {
              final val = await cont.verificationCheck(data);
              if (val == true) {
                Get.back();
                final result = await Get.to(() => ChatPage(data: data),
                    transition: Transition.rightToLeft);
                if (result != null) {
                  cont.verifications.value = null;
                  cont.currentPage=1;
                  cont.verificationAll();
                }
              }
            },
            btnTitle: 'Yes I will Check',
            title: "Proceed with verification?",
          ),
        ); // Use the separate BottomSheet widget
      },
    );
  }
}
