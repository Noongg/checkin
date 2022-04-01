import 'package:check_in/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/strings.dart';
import '../../widgets/loading_widget.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool hidePassWord = true;
  bool isChecked = false;

  void firebaseLogin() async {
    if (formKey.currentState!.validate()) {
      Get.dialog(const LoadingWidget());
      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text
        );

        print(userCredential.user!.email);
        print(userCredential.user!.displayName);
        print(userCredential.user!.getIdToken().toString());

        // Get.offAllNamed(Routes.HOMEPAGE);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Get.back();
          Get.snackbar("Lỗi", "No user found for that email.");
        } else if (e.code == 'wrong-password') {
          Get.back();
          Get.snackbar("Lỗi", "Wrong password provided for that user.");
        }
      }
    }
  }

  @override
  void onClose() {
    emailController.dispose();
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

  void updateIsChecked() {
    if (isChecked == false) {
      isChecked = true;
    } else {
      isChecked = false;
    }
    update(['isChecked']);
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

  String? validatePassword(String? value) {
    if (GetUtils.isNullOrBlank(value)!) {
      return StringUtils.not_enter_password_yet.tr;
    }
    return null;
  }
}
