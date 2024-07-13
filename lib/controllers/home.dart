import 'dart:convert';

import 'package:doss/constants/api.dart';
import 'package:doss/constants/cont.dart';
import 'package:doss/constants/local_db.dart';
import 'package:doss/services/api.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../view/widgets/custom_snackbar.dart';

class HomeCont extends GetxController {
  Future<void> updateStatus() async {
    try {
      final status = authCont.isOnline.value ? "Active" : "Inactive";
      authCont.isLoading.value = true;
      final response = await ApiService.put(
        endPoint: "${ApiUrls.endpoint}${ApiUrls.statusURL}$status",
        accessToken: authCont.accessToken.value,
      );
      if (response != null) {
        final responseBody = jsonDecode(response.body);
        if (response.statusCode == 200 || response.statusCode == 201) {
          showCustomSnackbar(false, "Status Updated");
        } else if (response.statusCode == 400) {
          showCustomSnackbar(true, "${responseBody["errors"][0]}");
        } else {
          showCustomSnackbar(true, "${responseBody["errors"][0]}");
        }
      } else {
        showCustomSnackbar(true, "Something went wrong");
      }
    } catch (e) {
      print(e.toString());
      showCustomSnackbar(true, "Something went wrong");
    } finally {
      authCont.isLoading.value = false;
    }
  }
}
