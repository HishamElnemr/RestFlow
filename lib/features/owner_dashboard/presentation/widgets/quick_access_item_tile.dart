import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

class QuickAccessItemTile extends StatelessWidget {
  const QuickAccessItemTile({
    super.key,
    required this.title,
    this.icon,
    this.svgPath,
    required this.color,
    this.onTap,
  }) : assert(icon != null || svgPath != null);

  final String title;
  final IconData? icon;
  final String? svgPath;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderLight),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (svgPath != null)
              SvgPicture.asset(
                svgPath!,
                colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                width: 26,
                height: 26,
              )
            else if (icon != null)
              Icon(
                icon,
                color: color,
                size: 26,
              ),
            const SizedBox(height: 8),
            Text(
              title,
              style: AppStyles.captionSemiBold12(context).copyWith(
                color: AppColors.darkNavy,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
