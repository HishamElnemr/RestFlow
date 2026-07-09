import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theme/app_colors.dart';

class OnboardingCarouselItem extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final LinearGradient gradient;

  const OnboardingCarouselItem({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: gradient,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 7.5,
                  offset: const Offset(0, 10),
                ),
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 3,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: SizedBox(
                width: 48,
                height: 48,
                child: SvgPicture.asset(
                  imagePath,
                  fit: BoxFit.contain,
                  colorFilter: const ColorFilter.mode(
                    AppColors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.darkNavy,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter',
                    ) ??
                const TextStyle(
                  fontSize: 24,
                  color: AppColors.darkNavy,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Inter',
                ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.mutedGray,
                        height: 1.5,
                        fontFamily: 'Inter',
                      ) ??
                  const TextStyle(
                    fontSize: 12,
                    height: 1.5,
                    color: AppColors.mutedGray,
                    fontFamily: 'Inter',
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
