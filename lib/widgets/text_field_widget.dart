import 'package:flutter/material.dart';

import '../utils/color_utils.dart';

class TextFieldWidget extends StatelessWidget {
  final String? title;
  final bool isRequired;
  final String? hintText;
  final bool obscureText;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final Function(String)? onChanged;
  final TextStyle? titleStyle;
  final EdgeInsets? contentPadding;
  final double? marginTitle;
  final Color? borderColor;

  const TextFieldWidget(
      {Key? key,
      this.title,
      this.isRequired = false,
      this.hintText,
      this.obscureText = false,
      this.validator,
      required this.controller,
      this.onChanged,
      this.titleStyle,
      this.contentPadding,
      this.marginTitle,
      this.borderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (title != null)
              Text(
                title!,
                style: titleStyle ??
                    const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF77828F),
                    ),
              ),
            if (title != null)
              const SizedBox(
                width: 2,
              ),
            if (isRequired)
              const Text(
                "*",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: ColorUtils.errorColor,
                ),
              ),
          ],
        ),
        SizedBox(
          height: marginTitle ?? 5,
        ),
        TextFormField(
          obscureText: obscureText,
          onChanged: onChanged,
          decoration: InputDecoration(
            isDense: true,
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: borderColor ?? const Color(0xFF0F296D),
              ),
              borderRadius: BorderRadius.zero,
            ),
            contentPadding: contentPadding ??
                const EdgeInsets.symmetric(
                  vertical: 10,
                ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: borderColor ?? const Color(0xFF0F296D),
              ),
              borderRadius: BorderRadius.zero,
            ),
            hintText: hintText,
            hintStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w200,
            ),
          ),
          validator: validator,
          controller: controller,
        ),
      ],
    );
  }
}
