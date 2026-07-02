import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class LoginAppbar extends StatelessWidget {
  const LoginAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Sign in to manage your restaurant',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 14,
        color: AppColors.mutedGray,
        fontFamily: 'Inter',
      ),
    );
  }
}
