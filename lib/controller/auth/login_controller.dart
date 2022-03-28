import 'package:check_in/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

import '../../utils/strings.dart';
import '../../widgets/loading_widget.dart';


class LoginController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool hidePassWord = true;
  bool isChecked = false;

  // void apiLogin() async {
  //   if (formKey.currentState!.validate()) {
  //     Get.dialog(const LoadingWidget());
  //     bool result = await AuthRepository.login(
  //       username: usernameController.text,
  //       password: passwordController.text,
  //     );
  //     if (result) {
  //       Get.offAllNamed(Routes.HOMEPAGE);
  //     } else {
  //       Get.snackbar("Lỗi", "Sai tên đăng nhập hoặc mật khẩu");
  //       Get.back();
  //     }
  //   }
  // }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }

  void updateHide() {
    if (hidePassWord == false) {
      hidePassWord = true;
      update();
    } else {
      hidePassWord = false;
      update();
    }
  }

  void updateIsChecked() {
    if (isChecked == false) {
      isChecked = true;
      update();
    } else {
      isChecked = false;
      update();
    }
  }
  String? validateUserName (String? value) {
    if (GetUtils.isNullOrBlank(value)!) {
      return StringUtils.not_enter_username_yet.tr;
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (GetUtils.isNullOrBlank(value)!) {
      return StringUtils.not_enter_password_yet.tr;
    }
    return null;
  }
}
