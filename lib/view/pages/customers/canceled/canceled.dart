import 'package:doss/constants/colors.dart';
import 'package:doss/controllers/customers.dart';
import 'package:doss/view/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/size_config.dart';
import '../components/customers_expansion_tile.dart';

class CanceledCustomersTab extends StatefulWidget {
  CanceledCustomersTab({Key? key}) : super(key: key);

  @override
  State<CanceledCustomersTab> createState() => _CanceledCustomersTabState();
}

class _CanceledCustomersTabState extends State<CanceledCustomersTab> {
  final cont = Get.find<CustomersCont>();
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    Future.delayed(
        Duration.zero, () => cont.getCancelledCustomersFromBackend());
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (!cont.cancelledReachesEnd.value) {
          cont.cancelledPageNo += 1;
          cont.getCancelledCustomersFromBackend();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => cont.getCancelledCustomers == null
        ? Center(
            child: LoadingWidget(height: SizeConfig.heightMultiplier * 20),
          )
        : cont.getCancelledCustomers!.isEmpty
            ? Center(
                child: Text('No Customers Found!'),
              )
            : ListView.builder(
                controller: scrollController,
                itemCount: cont.getCancelledCustomers!.length + 1,
                itemBuilder: (_, i) {
                  if (i == cont.getCancelledCustomers!.length) {
                    if (cont.cancelledReachesEnd.value) {
                      return SizedBox();
                    } else {
                      return Center(
                          child: CircularProgressIndicator(
                              color: AppColors.primaryClr, strokeWidth: 2));
                    }
                  }
                  return CustomersExpansionTile(
                    data: cont.getCancelledCustomers![i],
                  );
                }));
  }
}
