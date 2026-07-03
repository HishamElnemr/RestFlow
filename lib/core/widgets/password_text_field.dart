import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'custom_text_field.dart';

/// A specialized password text field that manages its own visibility state.
class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;

  const PasswordTextField({
    super.key,
    required this.controller,
    this.label = 'Password',
    this.hintText = 'Enter your password',
    this.validator,
    this.autovalidateMode,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: widget.controller,
      label: widget.label,
      hintText: widget.hintText,
      obscureText: _obscureText,
      validator: widget.validator,
      autovalidateMode: widget.autovalidateMode,
      suffixIcon: IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
          color: AppColors.mutedGray,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      ),
    );
  }
}
