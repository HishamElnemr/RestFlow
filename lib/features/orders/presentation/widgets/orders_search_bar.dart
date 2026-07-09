import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

class OrdersSearchBar extends StatelessWidget {
  const OrdersSearchBar({super.key, this.onChanged});

  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.borderLight,
          width: 1.18,
        ),
      ),
      child: TextField(
        onChanged: onChanged,
        cursorColor: AppColors.primary,
        style: AppStyles.body2Medium14(context).copyWith(
          color: AppColors.darkNavy,
        ),
        decoration: InputDecoration(
          hintText: 'Search by order number...',
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
