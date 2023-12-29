import 'package:flutter/material.dart';
import 'package:unipark_uitm_app/src/utils/constants/colors.dart';
import 'package:unipark_uitm_app/src/utils/helpers/helper_functions.dart';

class WTextFormField extends StatelessWidget {
  const WTextFormField({
    super.key,
    required this.controller,
    this.keyboardType,
    required this.obscureText,
    required this.enableSuggestions,
    required this.autocorrect,
    required this.validator,
    this.labelText,
    required this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.maxLength,
  });

  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool enableSuggestions;
  final bool autocorrect;
  final String? Function(String?)? validator;
  final String? labelText;
  final String? hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunction.isDarkMode(context);

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      enableSuggestions: enableSuggestions,
      autocorrect: autocorrect,
      obscureText: obscureText,
      validator: validator,
      maxLength: maxLength,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        counterText: '',
        labelText: labelText,
        hintText: hintText,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: dark ? whiteColor : borderColor),
        ),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: dark ? whiteColor : borderColor)),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(width: 2.0, color: primaryColor)),
      ),
    );
  }
}
