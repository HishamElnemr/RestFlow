import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

class ProductSaveButton extends StatelessWidget {
  const ProductSaveButton({
    super.key,
    required this.onPressed,
    required this.isLoading,
    required this.isDisabled,
    required this.label,
  });

  final VoidCallback onPressed;
  final bool isLoading;
  final bool isDisabled;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: (isLoading || isDisabled) ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.electricBlue,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppColors.electricBlue.withOpacity(0.5),
          disabledForegroundColor: Colors.white.withOpacity(0.8),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: (isLoading || isDisabled) ? 0 : 4,
          shadowColor: AppColors.electricBlue.withOpacity(0.4),
        ),
        child: isLoading
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.5,
                ),
              )
            : Text(
                label,
                style: AppStyles.body1Medium16(context).copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
