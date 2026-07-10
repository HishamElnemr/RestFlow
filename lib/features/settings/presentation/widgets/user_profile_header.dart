import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

class UserProfileHeader extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final bool isEditing;
  final VoidCallback onEditToggled;

  const UserProfileHeader({
    super.key,
    required this.imageUrl,
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
              'Personal Information',
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
              CircleAvatar(
                radius: 40,
                backgroundColor: AppColors.warmGray,
                backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
                child: imageUrl == null
                    ? const Icon(
                        Icons.person_outline,
                        size: 40,
                        color: AppColors.mutedGray,
                      )
                    : null,
              ),
              if (isEditing)
                Positioned(
                  bottom: 0,
                  right: 0,
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
