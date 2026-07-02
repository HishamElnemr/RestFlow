import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/password_text_field.dart';

class RegisterFormFields extends StatelessWidget {
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const RegisterFormFields({
    super.key,
    required this.fullNameController,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomTextField(
          controller: fullNameController,
          label: 'Full Name',
          hintText: 'Enter your full name',
          prefixIcon: const Icon(Icons.person_outline, color: AppColors.mutedGray),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Full Name is required';
            }
            return null;
          },
        ),
        const SizedBox(height: 24),
        CustomTextField(
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
        ),
        const SizedBox(height: 24),
        CustomTextField(
          controller: phoneController,
          label: 'Phone number',
          hintText: '101 234 5678',
          keyboardType: TextInputType.phone,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 16, right: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.phone_outlined, color: AppColors.mutedGray),
                const SizedBox(width: 8),
                const Text(
                  '+20',
                  style: TextStyle(
                    color: AppColors.darkNavy,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  width: 1,
                  height: 20,
                  color: AppColors.borderLight,
                ),
              ],
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Phone number is required';
            }
            final phoneRegex = RegExp(r'^1[0125]\d{8}$');
            if (!phoneRegex.hasMatch(value)) {
              return 'Enter a valid 10-digit Egypt phone number (e.g. 10xxxxxxxx)';
            }
            return null;
          },
        ),
        const SizedBox(height: 24),
        PasswordTextField(
          controller: passwordController,
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
          label: 'Confirm Password',
          hintText: 'Re-enter your password',
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Confirm Password is required';
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
