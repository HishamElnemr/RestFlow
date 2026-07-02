import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class RegisterFooterLinks extends StatelessWidget {
  final VoidCallback onSignInPressed;

  const RegisterFooterLinks({super.key, required this.onSignInPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onSignInPressed,
        child: RichText(
          text: const TextSpan(
            text: "Already have an account? ",
            style: TextStyle(
              color: AppColors.mutedGray,
              fontSize: 14,
              fontFamily: 'Inter',
            ),
            children: [
              TextSpan(
                text: 'Sign in',
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
