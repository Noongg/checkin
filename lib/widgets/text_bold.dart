import 'package:flutter/cupertino.dart';

Widget textBold(
    {required String text,
      required Color color,
      required double fontSize,
      TextAlign? textAlign}) {
  return Text(
    text,
    style: TextStyle(
      fontFamily: "Poppins-Bold",
      color: color,
      fontSize: fontSize,
    ),
    textAlign: textAlign,
  );
}
