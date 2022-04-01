
import 'package:get/get.dart';

import '../controller/auth/register_controller.dart';

class RegisterBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<RegisterController>(RegisterController());
  }
}
