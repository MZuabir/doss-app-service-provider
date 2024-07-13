import 'package:doss/constants/colors.dart';
import 'package:doss/controllers/emergency_tab.dart';
import 'package:doss/view/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/size_config.dart';
import 'components/customer_custom_tile.dart';

class EmergencyCustomersPage extends StatefulWidget {
  EmergencyCustomersPage({Key? key}) : super(key: key);

  @override
  State<EmergencyCustomersPage> createState() => _EmergencyCustomersPageState();
}

class _EmergencyCustomersPageState extends State<EmergencyCustomersPage> {
  final cont = Get.find<EmergencyTabCont>();
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (!cont.customersReachEnd.value) {
          cont.customersPageNumber += 1;
          cont.getResidentialContactsData();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => cont.getResidentialContacts == null
          ? LoadingWidget(height: SizeConfig.heightMultiplier * 70)
          : ListView.builder(
            controller: scrollController,
              itemCount: cont.getResidentialContacts!.length + 1,
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier*5),
              shrinkWrap: true,
              itemBuilder: (_, i) {
                if (i == cont.getResidentialContacts!.length) {
                  return cont.customersReachEnd.value
                      ? const SizedBox()
                      : Center(
                          child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.primaryClr,
                        ));
                } else {
                  return EmergencyCustomersCustomTile(
                    contact: cont.getResidentialContacts![i],
                  );
                }
              }),
    );
  }
}
