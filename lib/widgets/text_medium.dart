import 'package:flutter/cupertino.dart';

Widget textMedium(
    {required String text,
      required Color color,
      required double fontSize,
      TextAlign? textAlign}) {
  return Text(
    text,
    style: TextStyle(
      fontFamily: "Poppins-Medium",
      color: color,
      fontSize: fontSize,
    ),
    textAlign: textAlign,
  );
}
