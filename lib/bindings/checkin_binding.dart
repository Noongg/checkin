import 'package:get/get.dart';

import '../controller/controller_checkin.dart';

class CheckInBindings extends Bindings {

  @override
  void dependencies() {
    Get.put<ControllerCheckIn>(ControllerCheckIn());

  }
}