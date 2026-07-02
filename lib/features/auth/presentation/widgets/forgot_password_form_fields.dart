import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_text_field.dart';

class ForgotPasswordFormFields extends StatelessWidget {
  final TextEditingController emailController;

  const ForgotPasswordFormFields({
    super.key,
    required this.emailController,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: emailController,
      label: 'Email',
      hintText: 'Enter your email',
      keyboardType: TextInputType.emailAddress,
      prefixIcon: const Icon(Icons.email_outlined, color: AppColors.mutedGray),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email is required';
        }
        final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
        if (!emailRegex.hasMatch(value)) {
          return 'Enter a valid email address';
        }
        return null;
      },
    );
  }
}
