import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../controller/auth/register_controller.dart';
import '../../utils/color_utils.dart';
import '../../utils/icons.dart';
import '../../utils/strings.dart';
import '../../widgets/buttons.dart';
import '../../widgets/round_checkbox_widget.dart';
import '../../widgets/text_field_widget.dart';

class RegisterPage extends StatelessWidget {
  final RegisterController _signupController = Get.find();

  RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: GetBuilder<RegisterController>(
        init: RegisterController(),
        builder: (RegisterController controller) => GestureDetector(
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
              Container(
                color: const Color(0xff192434).withOpacity(0.5),
              ),
              Positioned(
                bottom: 0,
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
                    key: _signupController.formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: Get.height * 0.25,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).viewInsets.bottom >
                                    30
                                    ? 60
                                    : 0),
                            child: Container(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 32),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _fullNameField(),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  _emailField(),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  _passwordField(),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  _confirmPasswordField(),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  // _verifyView(),
                                  Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      RoundCheckBoxWidget(
                                        width: 22,
                                        height: 22,
                                        colorInActive: const Color(0xffDBDFE5),
                                        borderColorInActive:
                                        const Color(0xffDBDFE5),
                                        onChange: (bool? value) {
                                          controller.updateIsAgreeTerm();
                                        },
                                        value: controller.isCheckedAgreeTerm,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        child: RichText(
                                          text: TextSpan(
                                              text:
                                              StringUtils.agree_rules_1.tr,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Color(0xFF1C1C24),
                                                  fontWeight: FontWeight.w400),
                                              children: [
                                                TextSpan(
                                                  text: StringUtils
                                                      .agree_rules_2.tr,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: ColorUtils.primaryColor,
                                                      fontWeight:
                                                      FontWeight.w400),
                                                ),
                                              ]),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Center(
                                    child: ButtonWidget(
                                      title: StringUtils.sign_up.tr,
                                      height: 40,
                                      onTap: controller.firebaseSignUp,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  Center(
                                    child: RichText(
                                      text: TextSpan(
                                          text: StringUtils
                                              .already_have_an_account.tr,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff202832),
                                          ),
                                          children: [
                                            TextSpan(
                                              text:
                                              " " + StringUtils.sign_in.tr,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: ColorUtils.primaryColor,
                                              ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  Get.back();
                                                },
                                            ),
                                          ]),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: Get.height / 5 - MediaQuery.of(context).viewInsets.bottom,
                child: SvgPicture.asset(
                  IconUtils.icLogo,
                  height: 41,
                  color: ColorUtils.primaryColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


  Widget _fullNameField() {
    return TextFieldWidget(
      globalKey: _signupController.fullNameKey,
      focusNode: _signupController.fullNameFocusNode,
      title: StringUtils.full_name.tr,
      controller: _signupController.fullNameController,
      hintText: "deniel123@gmail.com",
      isRequired: true,
      validator: _signupController.validateFullName,
    );
  }

  Widget _emailField() {
    return TextFieldWidget(
      globalKey: _signupController.emailKey,
      focusNode: _signupController.emailFocusNode,
      title: StringUtils.email.tr,
      controller: _signupController.emailController,
      hintText: "deniel123@gmail.com",
      isRequired: true,
      validator: _signupController.validateEmail,
    );
  }

  Widget _passwordField() {
    return Column(
      children: [
        TextFieldWidget(
          globalKey: _signupController.passwordKey,
          focusNode: _signupController.passwordFocusNode,
          controller: _signupController.passwordController,
          obscureText: _signupController.hidePassWord,
          title: StringUtils.password.tr,
          hintText: "* * * * * *",
          isRequired: true,
          onChanged: _signupController.onChangedPass,
          validator: _signupController.validatePassword,
        ),
        GetBuilder(
          init: _signupController,
          builder: (RegisterController controller) => GridView.builder(
            primary: false,
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: Get.width / 50,
            ),
            itemBuilder: (_, index) {
              return _itemVerify(
                  isVerified:
                  _signupController.listVerifyPass[index].isVerified,
                  label: _signupController.listVerifyPass[index].label);
            },
            itemCount: _signupController.listVerifyPass.length,
          ),
        )
      ],
    );
  }

  Widget _itemVerify({required String label, required bool isVerified}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 5,
          height: 5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.5),
            color: isVerified ? Colors.green : Colors.grey,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: isVerified ? ColorUtils.successColor : ColorUtils.grey1Color,
          ),
        ),
      ],
    );
  }

  Widget _confirmPasswordField() {
    return TextFieldWidget(
      globalKey: _signupController.confirmPasswordKey,
      controller: _signupController.confirmPasswordController,
      focusNode: _signupController.confirmPasswordFocusNode,
      obscureText: _signupController.hidePassWord,
      title: StringUtils.confirm_password.tr,
      hintText: "* * * * * *",
      isRequired: true,
      validator: _signupController.validateConfirmPassword,
    );
  }

  // Widget _verifyView() {
  //   return SizedBox(
  //     height: 100,
  //     width: 400,
  //     child: Builder(builder: (context) {
  //       return WebView(
  //         initialUrl: '127.0.0.1',
  //         javascriptMode: JavascriptMode.unrestricted,
  //         onWebViewCreated: (WebViewController webViewController) async {
  //           _signupController.reCaptchaController = webViewController;
  //           String fileText =
  //           await rootBundle.loadString("assets/webpage/index.html");
  //           _signupController.reCaptchaController!.loadUrl(Uri.dataFromString(
  //               fileText,
  //               mimeType: 'text/html',
  //               encoding: Encoding.getByName('utf-8'))
  //               .toString());
  //         },
  //         onProgress: (int progress) {},
  //         javascriptChannels: {
  //           JavascriptChannel(
  //               name: 'Captcha',
  //               onMessageReceived: (JavascriptMessage message) {
  //                 // ignore: deprecated_member_use
  //                 Scaffold.of(context).showSnackBar(
  //                   SnackBar(content: Text(message.message)),
  //                 );
  //               })
  //         },
  //         navigationDelegate: (NavigationRequest request) {
  //           return NavigationDecision.prevent;
  //         },
  //         onPageStarted: (String url) {},
  //         onPageFinished: (String url) {},
  //         gestureNavigationEnabled: true,
  //         zoomEnabled: false,
  //         backgroundColor: const Color(0x00000000),
  //       );
  //     }),
  //   );
  // }
}
