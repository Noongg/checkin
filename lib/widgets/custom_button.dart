import 'package:check_in/widgets/text_bold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/color_utils.dart';

Widget customButton({required String text,required VoidCallback callback}){
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(Get.width, 57),
        primary: ColorUtils.colorPrimary
      ),
      onPressed:callback,
      child: textBold(text: text, color: Colors.white, fontSize: 14));
}