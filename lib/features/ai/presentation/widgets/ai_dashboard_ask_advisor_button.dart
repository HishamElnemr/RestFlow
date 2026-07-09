import 'package:flutter/material.dart';

import '../../../../core/routes/routes_name.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

class AiDashboardAskAdvisorButton extends StatelessWidget {
  const AiDashboardAskAdvisorButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: InkWell(
        onTap: () => Navigator.of(context).pushNamed(RoutesName.aiChat),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            gradient: AppColors.purpleHorizontalGradient,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1A000000),
                offset: Offset(0, 10),
                blurRadius: 7.5,
              ),
              BoxShadow(
                color: Color(0x1A000000),
                offset: Offset(0, 4),
                blurRadius: 3,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.auto_awesome_rounded,
                color: AppColors.white,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Ask AI Advisor',
                style: AppStyles.button1SemiBold16(context).copyWith(
                  color: AppColors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
