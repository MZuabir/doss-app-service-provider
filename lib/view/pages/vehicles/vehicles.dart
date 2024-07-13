import 'dart:developer';

import 'package:doss/constants/colors.dart';
import 'package:doss/constants/cont.dart';
import 'package:doss/controllers/vehicles.dart';
import 'package:doss/utils/size_config.dart';
import 'package:doss/utils/spacing.dart';
import 'package:doss/view/pages/add%20vehicle/add_vehicle.dart';
import 'package:doss/view/pages/vehicles/components/tile.dart';
import 'package:doss/view/widgets/background.dart';
import 'package:doss/view/widgets/custom_appbar.dart';
import 'package:doss/view/widgets/custom_button.dart';
import 'package:doss/view/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VehiclesPage extends StatefulWidget {
  const VehiclesPage({Key? key}) : super(key: key);
  
  @override
  State<VehiclesPage> createState() => _CarPageState();
}

class _CarPageState extends State<VehiclesPage> {
  final cont = Get.put(VehiclesCont());
  @override
  Widget build(BuildContext context) {
   
    return Obx(
      () => ShowLoading(
        inAsyncCall: authCont.isLoading.value,
        child: Scaffold(
          body: Background(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.widthMultiplier * 2.5),
              child: Column(
                children: [
                  Spacing.y(7),
                  CustomAppbar(
                    title: "vehicles",
                    isIcon: true,
                    onTap: () => Get.bottomSheet(AddVehicleBS(),
                        isScrollControlled: true),
                  ),
                  Spacing.y(7),
                  Expanded(
                    child: cont.getVehicles == null
                        ? LoadingWidget(
                            height: SizeConfig.heightMultiplier * 60)
                        : cont.getVehicles!.isEmpty
                            ? const Center(
                                child: Text('No Vehicles Found!'),
                              )
                            : SingleChildScrollView(
                                child: Column(
                                  children: [
                                    ...List.generate(
                                        cont.getVehicles!.length,
                                        (index) => VehiclesTile(
                                              index: index,
                                            )),
                                  ],
                                ),
                              ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}








// Obx(
// ()=> CustomDropDownField(
// hinttext: "Filter",
// listdata: cont.filterList,
// currentSelectedValue: cont.selectedFilter.value == ""
// ? null
// : cont.selectedFilter.value,
// onChanged: (value) {
// cont.selectedFilter.value = value.toString();
// },
// ),
// ),













