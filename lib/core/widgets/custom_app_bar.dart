import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../utils/app_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.showBottomBorder = true,
  });

  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool showBottomBorder;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      automaticallyImplyLeading: leading == null,
      leading: leading,
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

  @override
  Size get preferredSize => Size.fromHeight(
      kToolbarHeight + (showBottomBorder ? 1.18 : 0));
}
