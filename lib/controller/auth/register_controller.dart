import 'package:check_in/helper/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../routes/routes.dart';
import '../../utils/strings.dart';
import '../../widgets/loading_widget.dart';

class RegisterController extends GetxController {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  FocusNode fullNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  final fullNameKey = GlobalKey<FormFieldState>();
  final emailKey = GlobalKey<FormFieldState>();
  final passwordKey = GlobalKey<FormFieldState>();
  final confirmPasswordKey = GlobalKey<FormFieldState>();
  bool hidePassWord = true;
  bool isCheckedReceiveMail = false;
  bool isCheckedAgreeTerm = false;
  bool isCheckInternet = false;
  List<VerifyPass> listVerifyPass = [
    VerifyPass(label: "Có chữ thường"),
    VerifyPass(label: "Có chữ số"),
    VerifyPass(label: "Có chữ hoa"),
    VerifyPass(label: "Có ký tự đặc biệt"),
    VerifyPass(label: "Mật khẩu gồm ít nhất 8 ký tự"),
  ];

  void firebaseSignUp() async {
    if (formKey.currentState!.validate()) {
      Get.dialog(const LoadingWidget());
      {
        FirebaseHelper.registerFirebase(
            name: fullNameController.text,
            email: emailController.text,
            password: passwordController.text);
      }
    }
  }

  void onChangedPass(String text) {
    if (text != text.toLowerCase()) {
      listVerifyPass[2].isVerified = true;
    } else {
      listVerifyPass[2].isVerified = false;
    }
    if (text != text.toUpperCase()) {
      listVerifyPass[0].isVerified = true;
    } else {
      listVerifyPass[0].isVerified = false;
    }
    if (text.contains(RegExp(r'[0-9]'))) {
      listVerifyPass[1].isVerified = true;
    } else {
      listVerifyPass[1].isVerified = false;
    }
    if (text.contains(RegExp(r'[!@#$%^&*]'))) {
      listVerifyPass[3].isVerified = true;
    } else {
      listVerifyPass[3].isVerified = false;
    }
    if (text.length >= 8) {
      listVerifyPass[4].isVerified = true;
    } else {
      listVerifyPass[4].isVerified = false;
    }
    update();
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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    checkFocusNode();
  }

  void checkFocusNode() {
    fullNameFocusNode.addListener(() {
      if (!fullNameFocusNode.hasFocus) {
        fullNameKey.currentState!.validate();
      }
    });
    emailFocusNode.addListener(() {
      if (!emailFocusNode.hasFocus) {
        emailKey.currentState!.validate();
      }
    });
    passwordFocusNode.addListener(() {
      if (!passwordFocusNode.hasFocus) {
        passwordKey.currentState!.validate();
      }
    });
    confirmPasswordFocusNode.addListener(() {
      if (!confirmPasswordFocusNode.hasFocus) {
        confirmPasswordKey.currentState!.validate();
      }
    });
  }

  @override
  void dispose() {
    fullNameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  void onClose() {
    passwordController.dispose();
    super.onClose();
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

  void updateIsReceiveMail() {
    isCheckedReceiveMail = !isCheckedReceiveMail;
    update();
  }

  void updateIsAgreeTerm() {
    isCheckedAgreeTerm = !isCheckedAgreeTerm;
    update();
  }

  String? validateConfirmPassword(String? value) {
    if (passwordController.text != confirmPasswordController.text) {
      return StringUtils.password_not_match.tr;
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (GetUtils.isNullOrBlank(value)!) {
      return StringUtils.not_enter_password_yet.tr;
    }
    for (var element in listVerifyPass) {
      if (!element.isVerified) {
        return StringUtils.password_invalid.tr;
      }
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (GetUtils.isNullOrBlank(value)!) {
      return StringUtils.not_enter_email_yet.tr;
    }
    if (!GetUtils.isEmail(value!)) {
      return StringUtils.email_invalid.tr;
    }
    return null;
  }

  String? validateFullName(String? value) {
    if (GetUtils.isNullOrBlank(value)!) {
      return StringUtils.not_enter_full_name_yet.tr;
    }
    if (fullNameController.text.length < 10) {
      return StringUtils.full_name_invalid.tr;
    }
    return null;
  }
}

class VerifyPass {
  bool isVerified;
  String label;

  VerifyPass({this.isVerified = false, required this.label});
}
