import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

class ProductImagePicker extends StatelessWidget {
  const ProductImagePicker({
    super.key,
    required this.onTap,
    this.selectedImageFile,
    this.initialImageUrl,
  });

  final VoidCallback onTap;
  final File? selectedImageFile;
  final String? initialImageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.electricBlue.withOpacity(0.5), width: 2),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.electricBlue.withOpacity(0.1),
                    blurRadius: 15,
                    offset: const Offset(0, 4),
                  ),
                ],
                image: selectedImageFile != null
                    ? DecorationImage(
                        image: FileImage(selectedImageFile!),
                        fit: BoxFit.cover,
                      )
                    : (initialImageUrl != null && initialImageUrl!.isNotEmpty)
                        ? DecorationImage(
                            image: NetworkImage(initialImageUrl!),
                            fit: BoxFit.cover,
                          )
                        : null,
              ),
              child: (selectedImageFile == null &&
                      (initialImageUrl == null || initialImageUrl!.isEmpty))
                  ? const Center(
                      child: Icon(
                        Icons.add_a_photo_rounded,
                        color: AppColors.electricBlue,
                        size: 40,
                      ),
                    )
                  : null,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: Text(
            'Tap to upload an image',
            style: AppStyles.captionRegular12(context)
                .copyWith(color: AppColors.mutedGray),
          ),
        ),
      ],
    );
  }
}
