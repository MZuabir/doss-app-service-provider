import 'dart:convert';
import 'package:doss/controllers/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../constants/api.dart';
import '../constants/cont.dart';
import '../services/api.dart';
import '../view/widgets/custom_snackbar.dart';

class BaseAreaCont extends GetxController {
  final cont = Get.find<SignUpCont>();
  int area = 30;

  Future<void> postBaseArea() async {
    try {
      print(area);
      final body = {
        "coverageArea": area,
      };
      authCont.isLoading.value = true;
      final response = await ApiService.post(
        endPoint: '${ApiUrls.endpoint}service-provider/onboard/coverage-area', accessToken: authCont.accessToken.value,
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
    } catch (e) {
      authCont.isLoading.value = false;
      print(e);
      showCustomSnackbar(true, "Something went wrong");
    }
  }
}
