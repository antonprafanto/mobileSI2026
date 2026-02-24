import 'package:flutter/material.dart';

/// Widget TextField yang sudah dikonfigurasi untuk konsistensi tampilan
class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final bool obscureText;
  final bool readOnly;
  final int? maxLines;
  final int? maxLength;
  final String? hintText;
  final String? helperText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final VoidCallback? onTap;
  final String? Function(String?)? onSaved;
  final TextInputAction? textInputAction;
  final VoidCallback? onEditingComplete;

  const CustomTextField({
    super.key,
    this.controller,
    required this.label,
    required this.prefixIcon,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
    this.obscureText = false,
    this.readOnly = false,
    this.maxLines = 1,
    this.maxLength,
    this.hintText,
    this.helperText,
    this.validator,
    this.onChanged,
    this.onTap,
    this.onSaved,
    this.textInputAction,
    this.onEditingComplete,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      obscureText: obscureText,
      readOnly: readOnly,
      maxLines: maxLines,
      maxLength: maxLength,
      textInputAction: textInputAction,
      onChanged: onChanged,
      onTap: onTap,
      onSaved: onSaved,
      onEditingComplete: onEditingComplete,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        helperText: helperText,
        prefixIcon: Icon(prefixIcon),
        suffixIcon: suffixIcon != null ? Icon(suffixIcon, size: 18) : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
