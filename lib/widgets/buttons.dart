import 'package:flutter/material.dart';

import '../utils/color_utils.dart';

class ButtonWidget extends StatelessWidget {
  final Function onTap;
  final Color color;
  final String title;
  final TextStyle? textStyle;
  final double width;
  final double height;
  final double? borderRadius;
  const ButtonWidget(
      {Key? key,
      required this.onTap,
      this.color = ColorUtils.primaryColor,
      required this.title,
      this.textStyle,
      this.width = double.infinity,
      this.height = 50,
      this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
        ),
        child: Center(
          child: Text(
            title,
            style: textStyle ??
                const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
    );
  }
}
