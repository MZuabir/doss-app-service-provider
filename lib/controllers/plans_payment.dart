import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../constants/api.dart';
import '../constants/cont.dart';
import '../models/bank.dart';
import '../services/api.dart';
import '../view/pages/bottomnav/bottom_nav_bar.dart';
import '../view/widgets/custom_snackbar.dart';

class PlanPaymentCont extends GetxController {
  //FORM KEY
  final formKey = GlobalKey<FormState>();
  //CONTROLLERS
  TextEditingController homePrice = TextEditingController();
  TextEditingController commercialPrice = TextEditingController();
  TextEditingController agency = TextEditingController();
  TextEditingController account = TextEditingController();
  final FocusNode homeNode = FocusNode();
  final FocusNode commercialNode = FocusNode();
  final FocusNode agencyNode = FocusNode();
  final FocusNode accountNode = FocusNode();
  RxString? selectedBank = "".obs;
  RxString? selectedBankId = "".obs;
  Rxn<BankModel> banks = Rxn<BankModel>();
  BankModel? get getBankDetails => banks.value;

  Future<void> postPlanPaymentData() async {
    try {
      String? priceHome = homePrice.text;
      String? priceCommercial = commercialPrice.text;
      int? priceIntHome = int.tryParse(priceHome ?? '');
      int? priceIntCommerical = int.tryParse(priceCommercial ?? '');
      print(priceIntCommerical);
      final body = {
        "bankId": selectedBankId?.value,
        "agency": agency.text,
        "account": account.text,
        "plans": [
          {
            "description": "Residencia",
            "price": priceIntHome,
          },
          {
            "description": "Comercial",
            "price": priceIntCommerical,
          }
        ]
      };
      log(body.toString());
      authCont.isLoading.value = true;

      final response = await ApiService.post(
        endPoint: '${ApiUrls.endpoint}service-provider/onboard/form-payment', accessToken: authCont.accessToken.value,
        body: body,
        isAuth: false,
      );

      if (response != null) {
        final responseBody = jsonDecode(response.body);
        if (response.statusCode == 200 || response.statusCode == 201) {
          print(responseBody);
          print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
          Get.offAll(() => const BottomNavPage());
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
      showCustomSnackbar(true, "Something went wrong");
    }
  }

  
}
