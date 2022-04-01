import 'package:check_in/controller/auth/animation_login_controller.dart';
import 'package:check_in/controller/auth/login_controller.dart';
import 'package:check_in/utils/icons.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../routes/routes.dart';
import '../../utils/color_utils.dart';
import '../../utils/strings.dart';
import '../../widgets/buttons.dart';
import '../../widgets/round_checkbox_widget.dart';
import '../../widgets/text_field_widget.dart';

class LoginPage extends GetWidget<LoginController> {
  final LoginController _loginController = Get.find();

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AnimationLoginController>(
        builder: (AnimationLoginController animationLoginController) => GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Stack(
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
                builder: (contextAnimation, child) => Positioned(
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
                                      _emailField(),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      _passwordField(),
                                      const SizedBox(
                                        height: 40,
                                      ),
                                      Center(
                                        child: ButtonWidget(
                                          title: StringUtils.sign_in.tr,
                                          height: 40,
                                          onTap: controller.firebaseLogin,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      Center(
                                        child: RichText(
                                          text: TextSpan(
                                              text: StringUtils
                                                  .dont_have_an_account.tr,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff202832),
                                              ),
                                              children: [
                                                TextSpan(
                                                    text:
                                                    " ${StringUtils.sign_up.tr}",
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                      FontWeight.w400,
                                                      color: ColorUtils.primaryColor,
                                                    ),
                                                    recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () {
                                                        Get.toNamed(Routes
                                                            .RESGISTER_PAGE);
                                                      }),
                                              ]),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      Center(
                                        child: GestureDetector(
                                          child: Text(
                                            StringUtils.forgot_password.tr,
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: ColorUtils.primaryColor),
                                          ),
                                          onTap: () {},
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
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
                  builder: (_, child) {
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
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emailField() {
    return TextFieldWidget(
      title: StringUtils.email.tr,
      controller: _loginController.emailController,
      hintText: "deniel123@gmail.com",
      isRequired: true,
      validator: _loginController.validateEmail,
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
