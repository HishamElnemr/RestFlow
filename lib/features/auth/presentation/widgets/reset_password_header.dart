import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/restflow_logo.dart';

class ResetPasswordHeader extends StatelessWidget {
  const ResetPasswordHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        RestflowLogo(),
        SizedBox(height: 24),
        Text(
          'Reset Password',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppColors.darkNavy,
            fontFamily: 'Inter',
          ),
        ),
        SizedBox(height: 8),
        Text(
          "Enter your new password below to reset your account's password.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: AppColors.mutedGray,
            fontFamily: 'Inter',
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
