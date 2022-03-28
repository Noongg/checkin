import 'package:flutter/cupertino.dart';

Widget textLight(
    {required String text,
    required Color color,
    required double fontSize,
      TextDecoration? textDecoration}) {
  return Text(
    text,
    style: TextStyle(
      decoration: textDecoration,
      fontFamily: "Poppins-Light",
      color: color,
      fontSize: fontSize,
    ),
  );
}
