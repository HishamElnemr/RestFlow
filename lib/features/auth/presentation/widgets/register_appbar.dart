import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class RegisterAppbar extends StatelessWidget {
  const RegisterAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Create an account to get started',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 14,
        color: AppColors.mutedGray,
        fontFamily: 'Inter',
      ),
    );
  }
}
