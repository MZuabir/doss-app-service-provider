import 'dart:convert';
import 'package:doss/controllers/sign_up.dart';
import 'package:doss/controllers/user_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../constants/api.dart';
import '../constants/cont.dart';
import '../services/api.dart';
import '../view/widgets/custom_snackbar.dart';

class PatrolVehicleCont extends GetxController {
  final cont = Get.find<SignUpCont>();
  final userCont = Get.put(UserDataCont());

  TextEditingController brandCont = TextEditingController();
  TextEditingController modelCont = TextEditingController();
  // TextEditingController nameCont = TextEditingController();
  TextEditingController plateCont = TextEditingController();
  TextEditingController colorCont = TextEditingController();
  int? area;

  RxString selectedType = "Car".obs;
  RxBool defaultVehicle = true.obs;
  TextEditingController number = TextEditingController();
  final FocusNode numberNode = FocusNode();
  Rxn<XFile> photo = Rxn<XFile>();
  String base64Image = '';
  List<String> model = [];
  Map<String, List<String>> vehicleBrandsAndCars = {
    'Toyota': ['Camry', 'Corolla', 'Rav4', 'Highlander'],
    'Honda': ['Accord', 'Civic', 'CR-V', 'Pilot'],
    'Ford': ['Fusion', 'Focus', 'Escape', 'Explorer'],
    'Chevrolet': ['Malibu', 'Cruze', 'Equinox', 'Tahoe'],
    'Nissan': ['Altima', 'Maxima', 'Rogue', 'Pathfinder'],
    'BMW': ['3 Series', '5 Series', 'X3', 'X5'],
    'Mercedes-Benz': ['C-Class', 'E-Class', 'GLC', 'GLE'],
    'Audi': ['A4', 'A6', 'Q5', 'Q7'],
    'Tesla': ['Model S', 'Model 3', 'Model X', 'Model Y'],
    'Hyundai': ['Sonata', 'Elantra', 'Tucson', 'Santa Fe'],
    'Kia': ['Optima', 'Forte', 'Sorento', 'Telluride'],
  };
  List<String> type = [
    'Car',
  ];
  List<String> colors = [
    'White',
    'Black',
    'Silver',
    'Gray',
    'Blue',
    'Red',
    'Green',
    'Yellow',
    'Orange',
    'Brown',
    'Gold',
    'Purple',
  ];

  Future<void> postPatrolVehicle() async {
    try {
      if (_validator()) {
        final body = {
          "brand": brandCont.text,
          "model": modelCont.text,
          "plate": plateCont.text,
          "color": colorCont.text,
          "photo": base64Image,
          "defaultVehicle": defaultVehicle.value,
          "vehicleType": "${selectedType.value}",
        };
        print(body);

        if (base64Image != "") {
          authCont.isLoading.value = true;
          final response = await ApiService.post(
            endPoint: '${ApiUrls.endpoint}service-provider/onboard/vehicle',
            accessToken: authCont.accessToken.value,
            body: body,
            isAuth: false,
          );
          if (response != null) {
            final responseBody = jsonDecode(response.body);
            if (response.statusCode == 200 || response.statusCode == 201) {
              cont.pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
              // print(responseBody);
            } else if (response.statusCode == 400) {
              showCustomSnackbar(true, "${responseBody["errors"][0]}");
            } else {
              showCustomSnackbar(true, "${responseBody["errors"][0]}");
            }
          } else {
            showCustomSnackbar(true, "Something went wrong");
          }
          authCont.isLoading.value = false;
        }
      }
    } catch (e) {
      authCont.isLoading.value = false;
      print(e);
      showCustomSnackbar(true, "Something went wrong");
    }
  }

  bool _validator() {
    if (brandCont.text.isEmpty) {
      showCustomSnackbar(true, 'Brand is empty');
      return false;
    } else if (modelCont.text.isEmpty) {
      showCustomSnackbar(true, 'Model is empty');

      return false;
    } else if (plateCont.text.isEmpty) {
      showCustomSnackbar(true, 'Plate is empty');

      return false;
    } else if (colorCont.text.isEmpty) {
      showCustomSnackbar(true, 'Color is empty');

      return false;
    } else if (base64Image == '') {
      showCustomSnackbar(true, 'Photo is not selected"');
      return false;
    } else {
      return true;
    }
  }
}
