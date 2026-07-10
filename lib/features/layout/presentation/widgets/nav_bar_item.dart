import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

class NavBarItem extends StatelessWidget {
  const NavBarItem({
    super.key,
    this.icon,
    this.svgPath,
    required this.label,
    required this.isSelected,
    required this.onTap,
  }) : assert(icon != null || svgPath != null, 'Must provide either icon or svgPath');

  final IconData? icon;
  final String? svgPath;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? AppColors.primary : AppColors.mutedGray;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutQuint,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (svgPath != null)
              SvgPicture.asset(
                svgPath!,
                width: 22,
                height: 22,
                colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
              )
            else
              Icon(
                icon,
                size: 22,
                color: color,
              ),
            if (isSelected) ...[
              const SizedBox(width: 4),
              Text(
                label,
                style: AppStyles.captionBold12(context).copyWith(
                  color: AppColors.primary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
