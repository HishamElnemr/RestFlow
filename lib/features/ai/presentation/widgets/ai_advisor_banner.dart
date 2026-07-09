import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

class AiAdvisorBanner extends StatelessWidget {
  const AiAdvisorBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.purpleLavenderLight,
        border: Border(
          bottom: BorderSide(
            color: AppColors.purpleLight,
            width: 1.18,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Text(
        'Read-only advisor — cannot modify restaurant data',
        textAlign: TextAlign.center,
        style: AppStyles.captionRegular12(context).copyWith(
          color: AppColors.purpleDeep,
        ),
      ),
    );
  }
}
