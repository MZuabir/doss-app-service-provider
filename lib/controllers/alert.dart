import 'dart:convert';

import 'package:doss/constants/cont.dart';
import 'package:doss/models/alertModel.dart';
import 'package:get/get.dart';

import '../constants/api.dart';
import '../services/api.dart';
import '../view/widgets/custom_snackbar.dart';

class AlertCont extends GetxController {
  Rxn<AlertModel> alertData = Rxn<AlertModel>();
  AlertModel? get getAlertData => alertData.value;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Future.delayed(Duration.zero, () async {
      await checkStatus();
    });
  }

  Future<void> checkStatus() async {
    try {
      authCont.isLoading.value = true;
      final response = await ApiService.get(
        endPoint: '${ApiUrls.endpoint}service-provider/alert', accessToken: authCont.accessToken.value,
        isAuth: false,
      );

      // Check for an empty or malformed response body
      if (response != null && response.body.isNotEmpty) {
        if (response.statusCode == 200) {
          // Try to decode the JSON response
          final jsonData = jsonDecode(response.body);
          alertData.value = AlertModel.fromJson(jsonData);
          print(alertData.value);
        } else {
          showCustomSnackbar(true, "Something went wrong");
        }
      } else {
        showCustomSnackbar(true, "Something went wrong");
      }
    } catch (e) {
      // Handle other exceptions (e.g., network issues)
      print("Error: ${e.toString()}");
      print("Error status api $e");
      showCustomSnackbar(true, "Something went wrong");
    } finally {
      authCont.isLoading.value = false;
    }
  }
}
