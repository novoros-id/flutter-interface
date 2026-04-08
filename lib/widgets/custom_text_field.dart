import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final Widget? suffixWidget;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.controller,
    this.suffixWidget,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: AppTheme.textHintColor),
        suffixIcon: suffixWidget ??
            (suffixIcon != null ? Icon(suffixIcon, color: Colors.blueGrey) : null),
      ),
    );
  }
}