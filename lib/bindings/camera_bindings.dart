import 'package:check_in/controller/camera_controller.dart';
import 'package:get/get.dart';

class CameraBindings extends Bindings {

  @override
  void dependencies() {
    Get.put<ControllerCamera>(ControllerCamera());

  }
}