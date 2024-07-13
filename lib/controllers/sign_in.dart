import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignInCont extends GetxController {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  RxBool isEnabled = false.obs;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();

    emailController.addListener(() {
      updateButtonState();
    });

    passwordController.addListener(() {
      updateButtonState();
    });
  }

  void updateButtonState() {
    isEnabled.value = emailController.text.isNotEmpty && passwordController.text.isNotEmpty;
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
