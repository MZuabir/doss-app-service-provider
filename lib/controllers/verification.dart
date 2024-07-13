import 'dart:developer';
import 'package:doss/constants/api.dart';
import 'package:doss/constants/cont.dart';
import 'package:doss/models/verification_all.dart';
import 'package:doss/services/api.dart';
import 'package:doss/view/widgets/custom_snackbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class VerificationCont extends GetxController {
  int currentPage = 1;
  int totalPage = 10;
  RxBool isReachEnd = false.obs;
  RxString verificationID = "".obs;
  RxBool isVerificationLoading = false.obs;
//DATE FORMAT
  String formatDateTime(String dateTimeString) {
    final dateTime = DateTime.parse(dateTimeString);
    final formatter = DateFormat('MMMM dd, yyyy hh:mm:ss a');
    return formatter.format(dateTime);
  }

  Rxn<List<Verification>> verifications = Rxn<List<Verification>>();

//VERIFICATION REQUEST ALL
  Future<void> verificationAll() async {
    try {
      authCont.isLoading.value = true;
      final response = await ApiService.get(
        endPoint:
            "${ApiUrls.endpoint}${ApiUrls.verificationAllURL}Page=$currentPage&Total=4",
        accessToken: authCont.accessToken.value,
      );

      if (response != null) {
        if (response.statusCode == 200) {
          log((response.body));
          final model = verificationAllModelFromJson(response.body);
          if (currentPage == 1) {
            verifications.value = [];
          }
          
          if (model.data!.verifications!.isEmpty) {
            isReachEnd.value = true;
            return;
          }
          if(model.data!.verifications!.length<4){
            isReachEnd.value = true;
          }
          for (var element in model.data!.verifications!) {
            if (verifications.value!.isEmpty) {
              verifications.value!.add(element);
            } else if (verifications.value!.any((e) => e.id != element.id)) {
              verifications.value!.add(element);
            }
          }

          verifications.refresh();
        } else {
          showCustomSnackbar(true, "Something went wrong");
        }
      } else {
        showCustomSnackbar(true, "Something went wrong");
      }
    } catch (e) {
      showCustomSnackbar(true, "Something went wrong");
      debugPrint(e.toString());
    } finally {
      authCont.isLoading.value = false;
    }
  }

//VERIFICATION REQUEST CHECK
  Future<bool?> verificationCheck(Verification data) async {
    try {
      isVerificationLoading.value = true;
      final response = await ApiService.get(
        endPoint: ApiUrls.endpoint + ApiUrls.verificationCheckURL,
        accessToken: authCont.accessToken.value,
      );
      if (response != null) {
        if (response.statusCode == 200) {
          return true;
        } else {
          showCustomSnackbar(true, "Something went wrong");
        }
      } else {
        showCustomSnackbar(true, "Something went wrong");
      }
    } catch (e) {
      showCustomSnackbar(true, "Something went wrong");
      debugPrint(e.toString());
    } finally {
      isVerificationLoading.value = false;
    }
  }
}
