import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../utils/app_styles.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.showBottomBorder = true,
    this.floating = true,
    this.showBackButton = true,
  });

  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool showBottomBorder;
  final bool floating;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      automaticallyImplyLeading: showBackButton && leading == null,
      leading: leading,
      floating: floating,
      title: Text(
        title,
        style: AppStyles.heading3SemiBold18(context).copyWith(
          color: AppColors.darkNavy,
          fontSize: 22,
        ),
      ),
      actions: actions,
      bottom: showBottomBorder
          ? PreferredSize(
              preferredSize: const Size.fromHeight(1.18),
              child: Container(color: AppColors.warmGray, height: 1.18),
            )
          : null,
    );
  }
}
