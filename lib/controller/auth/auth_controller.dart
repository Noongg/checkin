import 'package:check_in/helper/storage_helper.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'login_controller.dart';

class AuthController extends GetxController {
  static LoginController loginController = Get.find();

  // AuthModel? authModel;
  bool isLogin = false;
  bool isCheckInternet = false;

  // void saveToken(AuthModel authModel) {
  //   this.authModel = authModel;
  //   if (loginController.isChecked) {
  //     StorageHelper.setAuth(
  //       authModel: authModel,
  //     );
  //   }
  //   update();
  // }

  // void checkAuth() async {
  //   authModel = await StorageHelper.getAuth();
  //   if (authModel != null) {
  //     isLogin = true;
  //   } else {
  //     isLogin = false;
  //   }
  //   update();
  // }

  @override
  void onInit() {
    // checkAuth();
    checkInternet();
    super.onInit();
  }

  void checkInternet() {
    InternetConnectionChecker().onStatusChange.listen((event) {
      isCheckInternet = event == InternetConnectionStatus.connected;
      if (isCheckInternet == false) {
        Get.snackbar('Thông báo', 'Mất mạng');
      }
      update();
    });
  }

  void resetVariable() {
    // authModel = null;
  }
}
