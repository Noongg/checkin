import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

import '../../utils/strings.dart';
import '../../widgets/loading_widget.dart';

enum SupportState {
  unknown,
  supported,
  unsupported,
}

class LoginController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool hidePassWord = true;
  bool isChecked = false;

  final LocalAuthentication auth = LocalAuthentication();
  SupportState supportState = SupportState.unknown;
  bool? canCheckBiometrics;
  bool? authenticated;
  List<BiometricType>? availableBiometrics;

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
    auth.isDeviceSupported().then((bool isSupported) => supportState =
        isSupported ? SupportState.supported : SupportState.unsupported);
  }

  Future<void> checkBiometrics() async {
    late bool isCanCheckBiometrics;
    try {
      isCanCheckBiometrics = await auth.canCheckBiometrics;
      _getAvailableBiometrics();
    } on PlatformException catch (e) {
      isCanCheckBiometrics = false;
      if (kDebugMode) {
        print(e);
      }
    }
    canCheckBiometrics = isCanCheckBiometrics;
    update();
  }

  Future<void> _getAvailableBiometrics() async {
    late List<BiometricType> isAvailableBiometrics;
    try {
      isAvailableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      isAvailableBiometrics = <BiometricType>[];
      print(e);
    }
    availableBiometrics = isAvailableBiometrics;
    update();
  }

  Future<void> authenticateWithBiometrics() async {
    bool isAuthenticated = false;
    try {
      isAuthenticated = await auth.authenticate(
          localizedReason:
              'Scan your fingerprint (or face or whatever) to authenticate',
          useErrorDialogs: true,
          stickyAuth: true,
          biometricOnly: true);
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return;
    }
    authenticated =isAuthenticated;
    if (kDebugMode) {
      print(authenticated);
    }
    update();
  }

  Future<void> checkAuthBiometrics() async {
    if (supportState == SupportState.unknown) {
      Get.snackbar(StringUtils.error.tr, StringUtils.device_not_found.tr);
    } else if (supportState == SupportState.supported) {
      await checkBiometrics();
      if (canCheckBiometrics!) {
        await authenticateWithBiometrics();
      }
    } else {
      Get.snackbar(StringUtils.error.tr, StringUtils.device_not_supported.tr);
    }
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

  String? validateUserName(String? value) {
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
