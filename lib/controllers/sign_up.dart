import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpCont extends GetxController {
  late TextEditingController emailController;
  RxBool isEnabled = false.obs;
  RxInt currentPage=0.obs;
  RxBool termsAndPolicies = false.obs;
  RxBool age = false.obs;
  PageController pageController = PageController();


  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    emailController.addListener(() {
      updateButtonState();
    });
  }
  void updateButtonState() {
    isEnabled.value =  termsAndPolicies.value && age.value;
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
