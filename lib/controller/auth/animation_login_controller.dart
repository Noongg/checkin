import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/color_utils.dart';

class AnimationLoginController extends GetxController with GetSingleTickerProviderStateMixin{
  Animation? fadeAnimation;
  Animation? scaleAnimation;
  Animation? transitionAnimation;
  Animation? colorAnimation;
  Animation? formFadeAnimation;
  Animation? splashColorAnimation;

  AnimationController? animationController;
  @override
  void onInit() {
    super.onInit();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    splashColorAnimation = ColorTween(
      begin: Colors.transparent,
      end: const Color(0xff192434).withOpacity(0.5),
    ).animate(
      CurvedAnimation(
        parent: animationController!,
        curve: const Interval(
          0.0, 0.4,
          curve: Curves.ease,
        ),
      ),
    );
    fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: animationController!,
        curve: const Interval(
          0.0, 0.4,
          curve: Curves.ease,
        ),
      ),
    );
    scaleAnimation= Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: animationController!,
        curve: const Interval(
          0.0, 0.4,
          curve: Curves.ease,
        ),
      ),
    );
    transitionAnimation = Tween<double>(
      begin: Get.height/2-20.5,
      end: Get.height/5,
    ).animate(
      CurvedAnimation(
        parent: animationController!,
        curve: const Interval(
          0.6, 1.0,
          curve: Curves.ease,
        ),
      ),
    );
    colorAnimation = ColorTween(
      begin: Colors.white,
      end: ColorUtils.primaryColor,
    ).animate(
      CurvedAnimation(
        parent: animationController!,
        curve: const Interval(
          0.6, 1.0,
          curve: Curves.ease,
        ),
      ),
    );
    formFadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: animationController!,
        curve: const Interval(
          0.6, 1.0,
          curve: Curves.ease,
        ),
      ),
    );
    animationController!.forward();
  }
}