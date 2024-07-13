import 'dart:developer';

import 'package:doss/constants/colors.dart';
import 'package:doss/controllers/customers.dart';
import 'package:doss/utils/size_config.dart';
import 'package:doss/view/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/customers_expansion_tile.dart';

class ActiveCustomersTab extends StatefulWidget {
  ActiveCustomersTab({Key? key}) : super(key: key);

  @override
  State<ActiveCustomersTab> createState() => _ActiveCustomersTabState();
}

class _ActiveCustomersTabState extends State<ActiveCustomersTab> {
  final cont = Get.find<CustomersCont>();
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => cont.getActiveCustomersFromBackend());
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (!cont.activeEndReachesEnd.value) {
          cont.activePageNo += 1;
          cont.getActiveCustomersFromBackend();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => cont.getActiveCustomers == null
        ? Center(
            child: LoadingWidget(height: SizeConfig.heightMultiplier * 20),
          )
        : cont.getActiveCustomers!.isEmpty
            ? Center(
                child: Text('No Customers Found!'),
              )
            : ListView.builder(
                controller: scrollController,
                itemCount: cont.getActiveCustomers!.length + 1,
                itemBuilder: (_, i) {
                  if (i == cont.getActiveCustomers!.length) {
                    if (cont.activeEndReachesEnd.value) {
                      return SizedBox();
                    } else {
                      return Center(
                          child: CircularProgressIndicator(
                              color: AppColors.primaryClr, strokeWidth: 2));
                    }
                  }
                  return CustomersExpansionTile(
                    data: cont.getActiveCustomers![i],
                  );
                }));
  }
}
