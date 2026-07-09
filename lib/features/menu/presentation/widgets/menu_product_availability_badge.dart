import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

class MenuProductAvailabilityBadge extends StatelessWidget {
  const MenuProductAvailabilityBadge({
    super.key,
    required this.isAvailable,
  });

  final bool isAvailable;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: isAvailable ? AppColors.oliveGreenLight : AppColors.ivory,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        isAvailable ? 'AVAILABLE' : 'UNAVAILABLE',
        style: AppStyles.overlineSemiBold10(context).copyWith(
          color: isAvailable ? AppColors.forestGreen : AppColors.mutedGray,
          letterSpacing: 0.275,
        ),
      ),
    );
  }
}
