import 'package:doss/constants/colors.dart';
import 'package:doss/controllers/history.dart';
import 'package:doss/utils/size_config.dart';
import 'package:doss/utils/spacing.dart';
import 'package:doss/view/widgets/loading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/history_custom_tile.dart';

class HistoryVerificationTab extends StatefulWidget {
  HistoryVerificationTab({Key? key}) : super(key: key);

  @override
  State<HistoryVerificationTab> createState() => _AllPageState();
}

class _AllPageState extends State<HistoryVerificationTab> {
  bool isEmpty = true;
  final cont = Get.find<HistoryCont>();
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    Future.delayed(
        Duration.zero, () => cont.getVerificationHistoryFromBackend());
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (!cont.verificationReachesEnd.value) {
          cont.verificationPageNo += 1;
          cont.getVerificationHistoryFromBackend();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Obx(
      () => cont.getVerificationHistory == null
          ? LoadingWidget(height: SizeConfig.heightMultiplier * 70)
          : cont.getVerificationHistory!.isEmpty
              ? Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.widthMultiplier * 2.5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "There are no records in your history yet",
                        style: textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ).tr(),
                      Spacing.y(3),
                      Container(
                        height: SizeConfig.heightMultiplier * 5,
                        width: SizeConfig.widthMultiplier * 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: AppColors.primaryClr),
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.heightMultiplier * 3),
                        child: Center(
                          child: Text(
                            "Invite family",
                            style: textTheme.bodyMedium!.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ).tr(),
                        ),
                      ),
                      Spacing.y(15),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.widthMultiplier * 2.5),
                    child: Column(
                      children: [
                        ListView.builder(
                            shrinkWrap: true,
                            controller: scrollController,
                            itemCount: cont.getVerificationHistory!.length + 1,
                            itemBuilder: (_, i) {
                              if (i == cont.getVerificationHistory!.length) {
                                if (cont.verificationReachesEnd.value ||
                                    cont.getVerificationHistory!.length < 7) {
                                  return SizedBox();
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(
                                        color: AppColors.primaryClr,
                                        strokeWidth: 2),
                                  );
                                }
                              }
                              return HistoryCustomTile(
                                model: cont.getVerificationHistory![i],
                              );
                            })
                      ],
                    ),
                  ),
                ),
    );
  }
}