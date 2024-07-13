import 'dart:convert';
import 'dart:developer';

import 'package:doss/constants/api.dart';
import 'package:doss/constants/cont.dart';
import 'package:doss/models/vehicles.dart';
import 'package:doss/services/api.dart';
import 'package:doss/view/widgets/custom_snackbar.dart';
import 'package:get/get.dart';

class ResidentialVehiclesCont extends GetxController {
  int currentPage = 1;
  RxBool onReachesEnd = false.obs;
  final Rxn<List<Vehicles>> vehicles = Rxn<List<Vehicles>>();
  List<Vehicles>? get getVehicles => vehicles.value;
  Future<void> getVehiclesFromBackend(String residentialID) async {
    try {
      final response = await ApiService.get(
          endPoint: ApiUrls.endpoint +
              'service-provider/customer/$residentialID/vehicles?page=$currentPage&total=6',
          accessToken: authCont.accessToken.value);
      if (response!.statusCode == 200) {
        log(response.body);
        final model = VehiclesModel.fromJson(jsonDecode(response.body));
        if (currentPage == 1) {
          vehicles.value = [];
        }
        if (currentPage == 1) {
          if (model.data!.vehicles!.length <= 6) {
            onReachesEnd.value = true;
          }
        }

        vehicles.value!.addAll(model.data!.vehicles!);
      }
    } catch (e) {
      log(e.toString());
      showCustomSnackbar(true, "Something went wrong");
    }
  }
}
