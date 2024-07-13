import 'package:doss/controllers/emergency_tab.dart';
import 'package:doss/view/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/size_config.dart';
import 'components/usefull_custom_tile.dart';

class UseFullContactsTab extends StatefulWidget {
  const UseFullContactsTab({Key? key}) : super(key: key);

  @override
  State<UseFullContactsTab> createState() => _UseFullContactsTabState();
}

class _UseFullContactsTabState extends State<UseFullContactsTab> {
  final cont = Get.find<EmergencyTabCont>();
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (!cont.usefullContactsReachEnd.value) {
          cont.usefullContactsPageNumber += 1;
          cont.getUsefullContactsData();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => cont.getUsefulContacts == null
          ? LoadingWidget(height: SizeConfig.heightMultiplier * 70)
          : ListView.builder(
              itemCount: cont.getUsefulContacts!.length,
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.widthMultiplier * 5),
              itemBuilder: (_, i) => UseFullContactCustomTile(
                    contact: cont.getUsefulContacts![i],
                  )),
    );
  }
}
