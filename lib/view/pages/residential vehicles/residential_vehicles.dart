import 'package:doss/constants/colors.dart';
import 'package:doss/constants/cont.dart';
import 'package:doss/controllers/residential_vehicles.dart';
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

class ResidentialVehiclesPage extends StatefulWidget {
  const ResidentialVehiclesPage({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  State<ResidentialVehiclesPage> createState() => _CarPageState();
}

class _CarPageState extends State<ResidentialVehiclesPage> {
  final cont = Get.put(ResidentialVehiclesCont());
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => cont.getVehiclesFromBackend(widget.id));
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (!cont.onReachesEnd.value) {
          cont.currentPage += 1;
          cont.getVehiclesFromBackend(widget.id);
        }
      }
    });
  }

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
                                        cont.getVehicles!.length + 1, (index) {
                                      if (index == cont.getVehicles!.length) {
                                        if (!cont.onReachesEnd.value) {
                                          return CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: AppColors.primaryClr,
                                          );
                                        } else {
                                          return const SizedBox();
                                        }
                                      }
                                      return VehiclesTile(
                                        isResidential: true,
                                        index: index,
                                      );
                                    }),
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













