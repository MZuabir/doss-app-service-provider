import 'package:doss/constants/colors.dart';
import 'package:doss/controllers/customers.dart';
import 'package:doss/utils/size_config.dart';
import 'package:doss/view/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../add vehicle/add_vehicle.dart';
import '../components/customers_expansion_tile.dart';

class AllCustomersTab extends StatefulWidget {
  AllCustomersTab({Key? key}) : super(key: key);

  @override
  State<AllCustomersTab> createState() => _AllCustomersTabState();
}

class _AllCustomersTabState extends State<AllCustomersTab> {
  final cont = Get.find<CustomersCont>();
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => cont.getAllCustomersFromBackend());
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (!cont.allReachesEnd.value) {
          cont.allCustomersPageNo += 1;
          cont.getAllCustomersFromBackend();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => cont.getAllCustomers == null
          ? const SizedBox()
          : cont.getAllCustomers!.isEmpty
              ? Center(
                  child: Text('No Customers Found!'),
                )
              : ListView.builder(
                  controller: scrollController,
                  itemCount: cont.getAllCustomers!.length + 1,
                  itemBuilder: (_, i) {
                    if (i == cont.getAllCustomers!.length) {
                      if (cont.allReachesEnd.value) {
                        return SizedBox();
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                              color: AppColors.primaryClr, strokeWidth: 2),
                        );
                      }
                    }

                    return CustomersExpansionTile(
                      data: cont.getAllCustomers![i],
                    );
                  }),
    );
  }
}
