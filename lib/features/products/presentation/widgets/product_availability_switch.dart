import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

class ProductAvailabilitySwitch extends StatelessWidget {
  const ProductAvailabilitySwitch({
    super.key,
    required this.isAvailable,
    required this.onChanged,
  });

  final bool isAvailable;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isAvailable
                      ? AppColors.successBright.withOpacity(0.1)
                      : AppColors.error.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isAvailable ? Icons.check_circle_outline : Icons.cancel_outlined,
                  color: isAvailable ? AppColors.successBright : AppColors.error,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Available',
                style: AppStyles.body1Medium16(context).copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkNavy,
                ),
              ),
            ],
          ),
          CupertinoSwitch(
            value: isAvailable,
            activeTrackColor: AppColors.electricBlue,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
