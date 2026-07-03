import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class AiInsightCard extends StatelessWidget {
  const AiInsightCard({super.key, this.onViewAllTap});

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
                const Text(
                  'AI Co-Pilot Insight',
                  style: TextStyle(
                    color: AppColors.purpleDeepAccent,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Your Margherita Pizza is running low and typically sells out by 6 PM on Mondays. Consider increasing prep quantities.',
                  style: TextStyle(
                    color: AppColors.darkNavy,
                    fontSize: 13,
                    height: 1.4,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(height: 12),
                InkWell(
                  onTap: onViewAllTap,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'View all insights',
                        style: TextStyle(
                          color: AppColors.purple,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter',
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
