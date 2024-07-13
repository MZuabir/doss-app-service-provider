import 'dart:convert';
import 'package:doss/controllers/sign_up.dart';
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

class UserDataCont extends GetxController {
  final cont = Get.find<SignUpCont>();
  //FORM KEY
  final formKey = GlobalKey<FormState>();
  //SIGNUP CONTROLLERS
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController document = TextEditingController();
  RxBool isCpfSelected = true.obs;
  RxBool isCpnjSelected = false.obs;
  final FocusNode nameNode = FocusNode();
  final FocusNode phoneNode = FocusNode();
  final FocusNode documentNode = FocusNode();
  Rxn<XFile> photo = Rxn<XFile>();
  String base64Image = '';

  Future<void> postUserData() async {
    try {
      final body = {
        "name": name.text,
        "document": document.text,
        "phone": phone.text,
        "photo": base64Image,
      };

      if (formKey.currentState!.validate() && base64Image != "") {
        authCont.isLoading.value = true;

        final response = await ApiService.post(
          endPoint:
              '${ApiUrls.endpoint}service-provider/onboard/user-information', accessToken: authCont.accessToken.value,
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
      } else {
        showCustomSnackbar(true, "Please Select Image");
      }
    } catch (e) {
      authCont.isLoading.value = false;
      // print(e);
      showCustomSnackbar(true, "Something went wrong");
    }
  }
}
