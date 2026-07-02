import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/restflow_logo.dart';

class ForgotPasswordHeader extends StatelessWidget {
  const ForgotPasswordHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        RestflowLogo(),
        SizedBox(height: 24),
        Text(
          'Forgot Password?',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppColors.darkNavy,
            fontFamily: 'Inter',
          ),
        ),
        SizedBox(height: 8),
        Text(
          "Don't worry! It happens. Please enter the email associated with your account.",
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
