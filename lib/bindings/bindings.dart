

import 'package:get/get.dart';
import '../controllers/auth.dart';

class AuthBindings extends Bindings {  
  @override
  void dependencies() {
    Get.lazyPut<AuthCont>(() => AuthCont());
  }
}
