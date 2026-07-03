import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_icon_button.dart';
import '../../../../core/widgets/custom_primary_button.dart';

class OnboardingControls extends StatelessWidget {
  final int currentIndex;
  final VoidCallback onNextPressed;
  final VoidCallback onBackPressed;
  final VoidCallback onSkipPressed;

  const OnboardingControls({
    super.key,
    required this.currentIndex,
    required this.onNextPressed,
    required this.onBackPressed,
    required this.onSkipPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            if (currentIndex > 0) ...[
              CustomIconButton(
                icon: Icons.chevron_left,
                onPressed: onBackPressed,
              ),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: CustomPrimaryButton(
                text: currentIndex == 2 ? 'Get Started' : 'Next',
                onPressed: onNextPressed,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        GestureDetector(
          onTap: onSkipPressed,
          child: Text(
            'Skip',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppColors.mutedGray,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter',
                    ) ??
                const TextStyle(
                  fontSize: 14,
                  color: AppColors.mutedGray,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Inter',
                ),
          ),
        ),
      ],
    );
  }
}
