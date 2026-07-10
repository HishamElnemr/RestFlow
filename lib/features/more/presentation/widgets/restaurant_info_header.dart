import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

class RestaurantInfoHeader extends StatelessWidget {
  final String? logoUrl;
  final String name;
  final bool isEditing;
  final VoidCallback onEditToggled;

  const RestaurantInfoHeader({
    super.key,
    required this.logoUrl,
    required this.name,
    required this.isEditing,
    required this.onEditToggled,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Restaurant Details',
              style: AppStyles.heading3SemiBold18(context).copyWith(
                color: AppColors.darkNavy,
              ),
            ),
            GestureDetector(
              onTap: onEditToggled,
              child: Row(
                children: [
                  Text(
                    isEditing ? 'Cancel' : 'Edit',
                    style: AppStyles.body2Medium14(context).copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    isEditing ? Icons.close : Icons.edit_outlined,
                    size: 16,
                    color: AppColors.primary,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Center(
          child: Stack(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.backgroundLight,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.warmGray, width: 1.18),
                  image: logoUrl != null
                      ? DecorationImage(
                          image: NetworkImage(logoUrl!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: logoUrl == null
                    ? const Icon(
                        Icons.storefront_outlined,
                        size: 40,
                        color: AppColors.mutedGray,
                      )
                    : null,
              ),
              if (isEditing)
                Positioned(
                  bottom: -8,
                  right: -8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.white, width: 2),
                    ),
                    child: const Icon(
                      Icons.camera_alt_outlined,
                      size: 14,
                      color: AppColors.white,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
