import 'dart:convert';
import 'package:doss/controllers/sign_up.dart';
import 'package:doss/models/zip_code.dart';
import 'package:doss/services/zipcode.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../constants/api.dart';
import '../constants/cont.dart';
import '../services/api.dart';
import '../view/widgets/custom_snackbar.dart';

class BaseAddressCont extends GetxController {
  RxBool isCheckingZipCode = false.obs;

  final cont = Get.find<SignUpCont>();
  //FORM KEY
  final formKey = GlobalKey<FormState>();
  //SIGNUP CONTROLLERS
  TextEditingController number = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController state = TextEditingController();

  TextEditingController zipCode = TextEditingController();
  TextEditingController complement = TextEditingController();
  final FocusNode numberNode = FocusNode();
  final FocusNode countryNode = FocusNode();
  final FocusNode cityNode = FocusNode();
  final FocusNode streetNode = FocusNode();
  final FocusNode zipCodeNode = FocusNode();
  final FocusNode complementNode = FocusNode();

  Future<void> postBaseAddress() async {
    try {
      final body = {
        "country": country.text,
        "state": state.text,
        "city": city.text,
        "street": street.text,
        "complement": complement.text,
        "zipCode": zipCode.text,
        "number": number.text,
      };
      authCont.isLoading.value = true;
      final response = await ApiService.post(
        endPoint: '${ApiUrls.endpoint}service-provider/onboard/address',
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
    } catch (e) {
      authCont.isLoading.value = false;
      // print(e);
      showCustomSnackbar(true, "Something went wrong");
    }
  }

  Future<void> checkZipCode(String val) async {
    try {
      isCheckingZipCode.value = true;
      final model = await ZipCodeService.getZipCodeDetails(val);
      if (model != null) {
        state.text = model.data!.state!.sigla!;
        city.text = model.data!.city!.name!;
        street.text = model.data!.street!;
        complement.text = model.data!.complement!;
        country.text = 'Brazil';
      }
    } catch (e) {
    } finally {
      isCheckingZipCode.value = false;
    }
  }
}
