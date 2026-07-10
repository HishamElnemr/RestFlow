import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/app_colors.dart';
import '../utils/app_styles.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    this.onChanged,
    this.hintText = 'Search...',
  });

  final ValueChanged<String>? onChanged;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderLight, width: 1.18),
      ),
      child: TextField(
        onChanged: onChanged,
        cursorColor: AppColors.primary,
        style: AppStyles.body2Medium14(context).copyWith(
          color: AppColors.darkNavy,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppStyles.body2Medium14(context).copyWith(
            color: AppColors.darkNavy.withAlpha(127),
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(13),
            child: SvgPicture.asset(
              'assets/images/search_normal.svg',
              width: 20,
              height: 20,
              colorFilter: ColorFilter.mode(
                AppColors.darkNavy.withAlpha(127),
                BlendMode.srcIn,
              ),
            ),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }
}
