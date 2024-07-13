import 'package:doss/constants/colors.dart';
import 'package:doss/constants/cont.dart';
import 'package:doss/controllers/alert.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/size_config.dart';
import '../../../utils/spacing.dart';
import '../../widgets/background.dart';
import 'components/notification_tile.dart';

class NotificationPage extends StatelessWidget {
  NotificationPage({Key? key}) : super(key: key);

  final cont = Get.put(AlertCont());

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Obx(
      () => Scaffold(
        body: Background(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.widthMultiplier * 2.5),
            child: Column(
              children: [
                Spacing.y(7),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () => Get.back(),
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        )),
                    Text("Notifications",
                            textAlign: TextAlign.center,
                            style: textTheme.bodyLarge!
                                .copyWith(fontWeight: FontWeight.w600))
                        .tr(),
                    SizedBox(
                      width: SizeConfig.widthMultiplier * 10,
                    )
                  ],
                ),
                Spacing.y(2),
                authCont.isLoading.value
                    ? Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                                child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.primaryClr,
                            )),
                          ],
                        ),
                      )
                    : cont.getAlertData?.data?.messages == null
                        ? const Expanded(
                            child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(child: Text("No Data")),
                            ],
                          ))
                        : Expanded(
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                children: [
                                  ...List.generate(
                                    cont.getAlertData!.data.messages.length,
                                    (index) => NotificationTile(
                                      title: cont.getAlertData!.data
                                          .messages[index].description,
                                      date: cont.getAlertData!.data
                                          .messages[index].created
                                          .substring(0, 10),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
