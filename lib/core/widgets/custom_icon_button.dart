import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;

  const CustomIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.darkNavy, // Ripple color
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: const BorderSide(
            color: AppColors.warmGray, // #e0ddd6
            width: 1.2,
          ),
        ),
        child: Icon(
          icon,
          size: 20,
          color: AppColors.darkNavy, // Assuming the icon is dark navy
        ),
      ),
    );
  }
}
