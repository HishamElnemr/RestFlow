import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

class AiInsightCard extends StatelessWidget {
  const AiInsightCard({
    super.key,
    required this.insightText,
    this.onViewAllTap,
  });

  final String insightText;
  final VoidCallback? onViewAllTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.purpleSoft,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.purpleLight.withOpacity(0.5),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.purpleLight.withOpacity(0.4),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.auto_awesome_rounded,
              color: AppColors.purple,
              size: 24,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AI Co-Pilot Insight',
                  style: AppStyles.captionSemiBold12(context).copyWith(
                    color: AppColors.purpleDeepAccent,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 6),
                ReadMoreText(
                  insightText,
                  trimLines: 4,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: ' read more',
                  trimExpandedText: ' show less',
                  moreStyle: AppStyles.captionSemiBold12(context).copyWith(
                    color: AppColors.purple,
                    fontSize: 13,
                  ),
                  lessStyle: AppStyles.captionSemiBold12(context).copyWith(
                    color: AppColors.purple,
                    fontSize: 13,
                  ),
                  style: AppStyles.captionSemiBold12(context).copyWith(
                    color: AppColors.darkNavy,
                    fontSize: 13,
                    height: 1.4,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 12),
                InkWell(
                  onTap: onViewAllTap,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'View all insights',
                        style: AppStyles.captionSemiBold12(context).copyWith(
                          color: AppColors.purple,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.arrow_forward_rounded,
                        color: AppColors.purple,
                        size: 14,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
