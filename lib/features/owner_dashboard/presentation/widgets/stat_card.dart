import 'package:flutter/material.dart';
import 'package:rest_flow/core/utils/app_styles.dart';

import '../../../../core/theme/app_colors.dart';

import 'package:flutter_svg/flutter_svg.dart';

class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    this.icon,
    this.svgAsset,
    required this.title,
    required this.value,
    required this.iconColor,
    required this.iconBgColor,
    this.borderColor,
  }) : assert(icon != null || svgAsset != null, 'Either icon or svgAsset must be provided');

  final IconData? icon;
  final String? svgAsset;
  final String title;
  final String value;
  final Color iconColor;
  final Color iconBgColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: borderColor ?? AppColors.borderLight,
          width: borderColor != null ? 1.5 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: svgAsset != null
                ? SvgPicture.asset(
                    svgAsset!,
                    width: 20,
                    height: 20,
                    colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                  )
                : Icon(
                    icon,
                    color: iconColor,
                    size: 20,
                  ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppStyles.captionSemiBold12(context).copyWith(
              color: AppColors.mutedGray,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppStyles.heading2Bold24(context).copyWith(
              color: AppColors.darkNavy,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
