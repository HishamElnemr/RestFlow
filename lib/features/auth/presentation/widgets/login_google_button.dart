import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class LoginGoogleButton extends StatelessWidget {
  final VoidCallback onPressed;

  const LoginGoogleButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.g_mobiledata, size: 24, color: AppColors.googleRed),
      label: const Text(
        'Sign in with Google',
        style: TextStyle(
          color: AppColors.darkNavy,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          fontFamily: 'Inter',
        ),
      ),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        side: const BorderSide(color: AppColors.borderLight),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
