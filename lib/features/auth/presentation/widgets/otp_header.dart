import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/restflow_logo.dart';

class OtpHeader extends StatelessWidget {
  final String email;

  const OtpHeader({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const RestflowLogo(),
        const SizedBox(height: 24),
        const Text(
          'Verification Code',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppColors.darkNavy,
            fontFamily: 'Inter',
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Please enter the code we sent to\n$email',
          textAlign: TextAlign.center,
          style: const TextStyle(
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
