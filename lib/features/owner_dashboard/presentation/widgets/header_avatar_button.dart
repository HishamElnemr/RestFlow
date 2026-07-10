import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

class HeaderAvatarButton extends StatelessWidget {
  const HeaderAvatarButton({
    super.key,
    required this.initials,
    required this.onTap,
  });

  final String initials;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 32,
        height: 32,
        decoration: const BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            initials.toUpperCase(),
            style: AppStyles.captionSemiBold12(context).copyWith(
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
