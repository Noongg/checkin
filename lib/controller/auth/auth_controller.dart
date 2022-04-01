import 'package:check_in/helper/storage_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'login_controller.dart';

class AuthController extends GetxController {
  static LoginController loginController = Get.find();

  bool isLogin = false;
  bool isCheckInternet = false;

  @override
  void onInit() {
    super.onInit();
    checkInternet();
    FirebaseAuth.instance.authStateChanges().listen(
      (User? user) {
        if (user == null) {
          isLogin = false;
        } else {
          isLogin = true;
        }
        update();
      },
    );
  }

  void checkInternet() {
    InternetConnectionChecker().onStatusChange.listen(
      (event) {
        isCheckInternet = event == InternetConnectionStatus.connected;
        if (isCheckInternet == false) {
          Get.snackbar('Thông báo', 'Mất mạng');
        }
        update();
      },
    );
  }
}
