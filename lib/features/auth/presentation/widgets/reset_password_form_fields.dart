import 'package:flutter/material.dart';

import '../../../../core/widgets/password_text_field.dart';

class ResetPasswordFormFields extends StatelessWidget {
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const ResetPasswordFormFields({
    super.key,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PasswordTextField(
          controller: passwordController,
          label: 'New Password',
          hintText: 'Enter new password',
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Password is required';
            }
            if (value.length < 5) {
              return 'Password must be at least 5 characters';
            }
            if (!RegExp(r'[a-z]').hasMatch(value)) {
              return 'Password must contain at least one lowercase letter';
            }
            return null;
          },
        ),
        const SizedBox(height: 24),
        PasswordTextField(
          controller: confirmPasswordController,
          label: 'Confirm New Password',
          hintText: 'Re-enter new password',
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please confirm your password';
            }
            if (value != passwordController.text) {
              return 'Passwords do not match';
            }
            return null;
          },
        ),
      ],
    );
  }
}
