import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class LoginOrDivider extends StatelessWidget {
  const LoginOrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(child: Divider(color: AppColors.borderLight)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'OR',
            style: TextStyle(
              color: AppColors.mutedGray,
              fontSize: 12,
              fontFamily: 'Inter',
            ),
          ),
        ),
        Expanded(child: Divider(color: AppColors.borderLight)),
      ],
    );
  }
}
