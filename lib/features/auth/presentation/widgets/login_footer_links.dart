import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class LoginFooterLinks extends StatelessWidget {
  final VoidCallback onSignUpPressed;

  const LoginFooterLinks({super.key, required this.onSignUpPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onSignUpPressed,
        child: RichText(
          text: const TextSpan(
            text: "Don't have an account? ",
            style: TextStyle(
              color: AppColors.mutedGray,
              fontSize: 14,
              fontFamily: 'Inter',
            ),
            children: [
              TextSpan(
                text: 'Sign up',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
