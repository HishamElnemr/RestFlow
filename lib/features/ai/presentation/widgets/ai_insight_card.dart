import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../domain/entities/dashboard_insight_entity.dart';

class AiInsightCard extends StatelessWidget {
  const AiInsightCard({super.key, required this.insight});

  final DashboardInsightEntity insight;

  @override
  Widget build(BuildContext context) {
    final config = _InsightCategoryConfig.fromCategory(insight.category);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: config.gradient,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.purpleLavenderLight, width: 1.18),
      ),
      padding: const EdgeInsets.all(17),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AiInsightCategoryIcon(color: config.iconColor, icon: config.icon),
          const SizedBox(width: 12),
          Expanded(
            child: AiInsightCardText(insight: insight),
          ),
        ],
      ),
    );
  }
}

class AiInsightCategoryIcon extends StatelessWidget {
  const AiInsightCategoryIcon({
    super.key,
    required this.color,
    required this.icon,
  });

  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Skeleton.replace(
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
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: AppColors.white, size: 20),
      ),
    );
  }
}

class AiInsightCardText extends StatelessWidget {
  const AiInsightCardText({super.key, required this.insight});

  final DashboardInsightEntity insight;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          insight.category,
          style: AppStyles.body2Medium14(context).copyWith(
            color: AppColors.darkNavy,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          insight.insight,
          style: AppStyles.body2Regular14(context).copyWith(
            color: AppColors.darkNavy.withAlpha(204),
            height: 1.625,
          ),
        ),
      ],
    );
  }
}

class _InsightCategoryConfig {
  const _InsightCategoryConfig({
    required this.iconColor,
    required this.icon,
    required this.gradient,
  });

  final Color iconColor;
  final IconData icon;
  final LinearGradient gradient;

  factory _InsightCategoryConfig.fromCategory(String category) {
    final lower = category.toLowerCase();
    if (lower.contains('inventory')) {
      return _InsightCategoryConfig(
        iconColor: AppColors.brightOrange,
        icon: Icons.inventory_2_rounded,
        gradient: AppColors.orangeSoftGradient,
      );
    }
    if (lower.contains('menu') || lower.contains('engineering')) {
      return _InsightCategoryConfig(
        iconColor: AppColors.electricBlue,
        icon: Icons.trending_up_rounded,
        gradient: AppColors.skyBlueSoftGradient,
      );
    }
    return _InsightCategoryConfig(
      iconColor: AppColors.successBright,
      icon: Icons.bar_chart_rounded,
      gradient: AppColors.successSoftGradient,
    );
  }
}
