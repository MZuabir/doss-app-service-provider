import 'package:doss/constants/colors.dart';
import 'package:doss/controllers/customers.dart';
import 'package:doss/view/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/size_config.dart';
import '../components/customers_expansion_tile.dart';

class PendingCustomersTab extends StatefulWidget {
  PendingCustomersTab({Key? key}) : super(key: key);

  @override
  State<PendingCustomersTab> createState() => _PendingCustomersTabState();
}

class _PendingCustomersTabState extends State<PendingCustomersTab> {
  final cont = Get.find<CustomersCont>();
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => cont.getPendingCustomersFromBackend());
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (!cont.pendingReachesEnd.value) {
          cont.pendingPageNo += 1;
          cont.getPendingCustomersFromBackend();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => cont.getPendingCustomers == null
        ? Center(
            child: LoadingWidget(height: SizeConfig.heightMultiplier * 20),
          )
        : cont.getPendingCustomers!.isEmpty
            ? Center(
                child: Text('No Customers Found!'),
              )
            : ListView.builder(
                controller: scrollController,
                itemCount: cont.getPendingCustomers!.length + 1,
                itemBuilder: (_, i) {
                  if (i == cont.getPendingCustomers!.length) {
                    if (cont.pendingReachesEnd.value) {
                      return SizedBox();
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                            color: AppColors.primaryClr, strokeWidth: 2),
                      );
                    }
                  }
                  return CustomersExpansionTile(
                    data: cont.getPendingCustomers![i],
                  );
                }));
  }
}
