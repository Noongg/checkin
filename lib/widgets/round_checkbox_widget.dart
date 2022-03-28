import 'package:flutter/material.dart';

import '../utils/color_utils.dart';

class RoundCheckBoxWidget extends StatelessWidget {
  const RoundCheckBoxWidget(
      {Key? key,
        required this.onChange,
        required this.value,
        this.colorActive = ColorUtils.primaryColor,
        this.borderColorInActive = Colors.grey,
        this.checkColor = Colors.white,
        this.borderRadius,
        this.colorInActive = Colors.transparent,
        this.width = 30,
        this.height = 30})
      : super(key: key);

  /// Handle change value of checkbox
  final Function(bool?) onChange;

  /// Value of checkbox
  final bool value;

  /// Color of checkbox when active, default set to [ColorUtils.redColor6]
  final Color colorActive;

  /// Color of checkbox when active, default set to [Colors.transparent]
  final Color colorInActive;

  /// Color of border checkbox when inactive, default set to [ColorUtils.greyColor6]
  final Color borderColorInActive;

  /// Color of check mark, default set to [ColorUtils.whiteColor]
  final Color checkColor;

  /// Border radius of checkbox
  final BorderRadius? borderRadius;

  /// Width of checkbox, default set to 30
  final double width;

  /// Height of checkbox, default set to 30
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: value ? colorActive : borderColorInActive,
          width: 1,
        ),
        borderRadius: borderRadius ??
            const BorderRadius.all(
              Radius.circular(4),
            ),
        color: value ? colorActive : colorInActive,
      ),
      width: width,
      height: height,
      child: Theme(
        data: ThemeData(
          unselectedWidgetColor: Colors.transparent,
        ),
        child: Checkbox(
          activeColor: Colors.transparent,
          checkColor: checkColor,
          value: value,
          tristate: false,
          onChanged: onChange,
        ),
      ),
    );
  }
}
