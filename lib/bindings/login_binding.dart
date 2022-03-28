
import 'package:get/get.dart';

import '../controller/auth/animation_login_controller.dart';
import '../controller/auth/login_controller.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<LoginController>(LoginController());
    Get.put<AnimationLoginController>(AnimationLoginController());
  }
}
