import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import 'nav_bar_item.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NavBarItem(
                icon: Icons.grid_view_rounded,
                label: 'Dashboard',
                isSelected: currentIndex == 0,
                onTap: () => onTap(0),
              ),
              NavBarItem(
                svgPath: 'assets/images/onboarding2.svg',
                label: 'Orders',
                isSelected: currentIndex == 1,
                onTap: () => onTap(1),
              ),
              NavBarItem(
                svgPath: 'assets/images/menu.svg',
                label: 'Menu',
                isSelected: currentIndex == 2,
                onTap: () => onTap(2),
              ),
              NavBarItem(
                icon: Icons.auto_awesome_rounded,
                label: 'AI',
                isSelected: currentIndex == 3,
                onTap: () => onTap(3),
              ),
              NavBarItem(
                icon: Icons.more_horiz_rounded,
                label: 'More',
                isSelected: currentIndex == 4,
                onTap: () => onTap(4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
