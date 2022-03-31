import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../controller/auth/animation_login_controller.dart';
import '../../controller/auth/login_controller.dart';
import '../../routes/routes.dart';
import '../../utils/color_utils.dart';
import '../../utils/icons.dart';
import '../../utils/strings.dart';
import '../../widgets/buttons.dart';
import '../../widgets/round_checkbox_widget.dart';
import '../../widgets/text_field_widget.dart';

class LoginPage extends GetWidget<LoginController> {
  final LoginController _loginController = Get.find();

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.transparent),
      child: Scaffold(
        body: GetBuilder<AnimationLoginController>(
          builder: (AnimationLoginController animationLoginController) => Stack(
            children: [
              SizedBox(
                height: Get.height,
                width: Get.width,
                child: Image.asset(
                  IconUtils.bgSplash,
                  fit: BoxFit.fill,
                ),
              ),
              AnimatedBuilder(
                animation: animationLoginController.animationController!,
                builder: (context, child) => Container(
                  color: animationLoginController.splashColorAnimation!.value,
                ),
              ),
              AnimatedBuilder(
                animation: animationLoginController.animationController!,
                builder: (context, child) => Positioned(
                  bottom: 0,
                  child: Opacity(
                    opacity: animationLoginController.formFadeAnimation!.value,
                    child: Container(
                      height: Get.height * 0.9,
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.elliptical(
                            Get.width / 2,
                            Get.height / 4,
                          ),
                        ),
                        color: Colors.white,
                      ),
                      child: Form(
                        key: controller.formKey,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: Get.height * 0.25,
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom >
                                              30
                                          ? 100
                                          : 0),
                                  child: Column(
                                    children: [
                                      _userNameField(),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      _passwordField(),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              GetBuilder(
                                                builder: (LoginController
                                                        controller) =>
                                                    RoundCheckBoxWidget(
                                                        width: 20,
                                                        height: 20,
                                                        onChange:
                                                            (bool? value) {
                                                          controller
                                                              .updateIsChecked();
                                                        },
                                                        value: controller
                                                            .isChecked),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                StringUtils.remember_me.tr,
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xFF77828F),
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                          GestureDetector(
                                            onTap: () {},
                                            child: Text(
                                              " ${StringUtils.forgot_password.tr}",
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: ColorUtils.primaryColor,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      Row(
                                        children: [
                                          Flexible(
                                            child: ButtonWidget(
                                              title: StringUtils.sign_in.tr,
                                              height: 40,
                                              onTap: () {},
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              await _loginController
                                                  .checkAuthBiometrics();
                                            },
                                            child: const Icon(
                                              Icons.fingerprint,
                                              color: ColorUtils.primaryColor,
                                              size: 35,
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 24,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedBuilder(
                animation: animationLoginController.animationController!,
                builder: (context, child) {
                  return Positioned(
                    left: 0,
                    right: 0,
                    top: animationLoginController.transitionAnimation!.value -
                        MediaQuery.of(context).viewInsets.bottom,
                    child: Transform.scale(
                      scale: animationLoginController.scaleAnimation!.value,
                      child: Opacity(
                        opacity: animationLoginController.fadeAnimation!.value,
                        child: SvgPicture.asset(
                          IconUtils.icLogo,
                          height: 41,
                          color: animationLoginController.colorAnimation!.value,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _userNameField() {
    return TextFieldWidget(
      title: StringUtils.username.tr,
      controller: _loginController.usernameController,
      hintText: "deniel123@gmail.com",
      isRequired: true,
      validator: _loginController.validateUserName,
    );
  }

  Widget _passwordField() {
    return TextFieldWidget(
      controller: _loginController.passwordController,
      obscureText: _loginController.hidePassWord,
      title: StringUtils.password.tr,
      hintText: "* * * * * *",
      isRequired: true,
      validator: _loginController.validatePassword,
    );
  }
}
