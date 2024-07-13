import 'dart:convert';
import 'dart:developer';

import 'package:doss/constants/api.dart';
import 'package:doss/constants/cont.dart';
import 'package:doss/controllers/vehicles.dart';
import 'package:doss/services/api.dart';
import 'package:doss/services/image_picker.dart';
import 'package:doss/view/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddVehicleCont extends GetxController {
  RxBool isKeyboardOpen = false.obs;
  //FOCUS NODES
  FocusNode brandFocusNode = FocusNode();
  FocusNode modelFocusNode = FocusNode();
  FocusNode plateFocusNode = FocusNode();
  FocusNode colorFocusNode = FocusNode();

  final vehicleCont = Get.find<VehiclesCont>();
  RxString selectedImgPath = ''.obs;
  RxString selectedType = ''.obs;
  TextEditingController brandCont = TextEditingController();
  TextEditingController modelCont = TextEditingController();
  // TextEditingController nameCont = TextEditingController();
  TextEditingController plateCont = TextEditingController();
  TextEditingController colorCont = TextEditingController();

  Future<void> addVehicle() async {
    try {
      if (_validator()) {
        authCont.isLoading.value = true;
        final base64Img = await ImagePickerService.xFileToBase64(
            XFile(selectedImgPath.value));
        final body = {
          "brand": brandCont.text,
          "model": modelCont.text,
          "color": colorCont.text,
          "plate": plateCont.text,
          "photo": base64Img,
          "defaultVehicle": true,
          "vehicleType":
              selectedType.value
        };
        final response = await ApiService.post(
            endPoint: ApiUrls.endpoint + ApiUrls.updateVehicle,
            accessToken: authCont.accessToken.value,
            body: body);
        if (response!.statusCode == 200) {
          
          Get.back();
          showCustomSnackbar(false, 'Vehicle added successfully.');
          //LOAD AGAIN THE LIST
          vehicleCont.currentPage = 1;
          vehicleCont.vehicles.value = null;
          vehicleCont.getVehiclesFromBackend();
        } else {
          showCustomSnackbar(true, 'Something went wrong');
        }
      }
    } catch (e) {
      print(e);
      showCustomSnackbar(true, 'Something went wrong');

      authCont.isLoading.value = false;
    } finally {
      authCont.isLoading.value = false;
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
    } else if (selectedImgPath.value == '') {
      showCustomSnackbar(true, 'Photo is not selected"');
      return false;
    } else {
      return true;
    }
  }

  _focusNodeListener() {
    brandFocusNode
        .addListener(() => isKeyboardOpen.value = brandFocusNode.hasFocus);
    plateFocusNode
        .addListener(() => isKeyboardOpen.value = plateFocusNode.hasFocus);
    modelFocusNode
        .addListener(() => isKeyboardOpen.value = modelFocusNode.hasFocus);
    colorFocusNode
        .addListener(() => isKeyboardOpen.value = colorFocusNode.hasFocus);
  }

  @override
  void onInit() {
    super.onInit();
    _focusNodeListener();
  }
}
