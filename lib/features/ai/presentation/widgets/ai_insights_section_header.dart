import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

class AiInsightsSectionHeader extends StatelessWidget {
  const AiInsightsSectionHeader({super.key, required this.onRefresh});

  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Skeleton.replace(
          width: 40,
          height: 40,
          replacement: Bone.square(
            size: 40,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.purpleAccent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.auto_awesome_rounded,
              color: AppColors.white,
              size: 20,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'AI Insights',
              style: AppStyles.heading3SemiBold18(context).copyWith(
                color: AppColors.darkNavy,
              ),
            ),
            Text(
              'Real-time business intelligence',
              style: AppStyles.captionRegular12(context).copyWith(
                color: AppColors.mutedGray,
              ),
            ),
          ],
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(
            Icons.refresh_rounded,
            color: AppColors.primaryLight,
            size: 22,
          ),
          onPressed: onRefresh,
        ),
      ],
    );
  }
}
