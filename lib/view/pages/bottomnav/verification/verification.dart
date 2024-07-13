import 'package:doss/constants/colors.dart';
import 'package:doss/constants/cont.dart';
import 'package:doss/controllers/verification.dart';
import 'package:doss/utils/size_config.dart';
import 'package:doss/utils/spacing.dart';
import 'package:doss/view/pages/history/history.dart';
import 'package:doss/view/widgets/background.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/verification_card.dart';

class VerificationPage extends StatefulWidget {
  VerificationPage({Key? key}) : super(key: key);

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final cont = Get.put(VerificationCont());
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await cont.verificationAll();
      _scrollController.addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          if (!cont.isReachEnd.value) {
            cont.currentPage += 1;
            cont.verificationAll();
          }
        }
      });
    });
  }

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
                GestureDetector(
                  onTap: () {
                    cont.verificationAll();
                  },
                  child: Text("Verifications",
                          textAlign: TextAlign.center,
                          style: textTheme.bodyLarge!
                              .copyWith(fontWeight: FontWeight.w600))
                      .tr(),
                ),
                cont.verifications!.value == null
                    ? Spacing.y(37)
                    : Spacing.y(4),
                cont.verifications!.value == null
                    ? CircularProgressIndicator(color: AppColors.primaryClr)
                    : cont.verifications!.value!.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "There are no new verification requests at this time",
                                style: textTheme.bodyMedium!
                                    .copyWith(fontWeight: FontWeight.w600),
                              ).tr(),
                              Spacing.y(2),
                              InkWell(
                                onTap: (){
                                  Get.to(()=>HistoryPage());
                                },
                                borderRadius: BorderRadius.circular(30),
                                child: Container(
                                  height: SizeConfig.heightMultiplier * 6,
                                  width: SizeConfig.widthMultiplier * 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: AppColors.primaryClr,
                                  ),
                                  child: Center(
                                      child: Text(
                                    "View History",
                                    style: textTheme.headlineSmall,
                                  ).tr()),
                                ),
                              )
                            ],
                          )
                        : Expanded(
                            child: SingleChildScrollView(
                              controller: _scrollController,
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                children: [
                                  ...List.generate(
                                      cont.isReachEnd.value
                                          ? cont.verifications!.value!.length
                                          : cont.verifications!.value!.length +
                                              1, (index) {
                                    if (!cont.isReachEnd.value) {
                                      if (index ==
                                          cont.verifications!.value!.length) {
                                        return CircularProgressIndicator(
                                            color: AppColors.primaryClr,
                                            strokeWidth: 1.5);
                                      }
                                    }

                                    return VerificationCard(
                                      data: cont.verifications!.value![index],
                                    );
                                  }),
                                ],
                              ),
                            ),
                          )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
