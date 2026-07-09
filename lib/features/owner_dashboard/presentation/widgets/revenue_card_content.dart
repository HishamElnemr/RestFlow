import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../reports/domain/entities/financial_summary_entity.dart';

class RevenueCardContent extends StatelessWidget {
  final FinancialSummaryEntity summary;

  const RevenueCardContent({
    super.key,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '\$${summary.totalRevenue.toStringAsFixed(2)}',
          style: AppStyles.heading1Bold32(context).copyWith(
            color: AppColors.white,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Icon(
              summary.revenueGrowth.startsWith('-')
                  ? Icons.trending_down_rounded
                  : Icons.trending_up_rounded,
              color: AppColors.whiteOpacity80,
              size: 18,
            ),
            const SizedBox(width: 6),
            Text(
              summary.revenueGrowth,
              style: AppStyles.captionSemiBold12(context).copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              'vs previous period',
              style: AppStyles.captionRegular12(context).copyWith(
                color: AppColors.whiteOpacity80,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
