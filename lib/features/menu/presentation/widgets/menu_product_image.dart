import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

class MenuProductImage extends StatelessWidget {
  const MenuProductImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      color: AppColors.surfaceLight,
      child: Center(
        child: Container(
          width: 64,
          height: 64,
          decoration: const BoxDecoration(
            color: AppColors.borderLight,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '🍕',
              style: AppStyles.heading1Bold32(context),
            ),
          ),
        ),
      ),
    );
  }
}
