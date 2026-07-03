import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class PageIndicator extends StatelessWidget {
  final int count;
  final int currentIndex;

  const PageIndicator({
    super.key,
    required this.count,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        count,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: EdgeInsets.only(right: index < count - 1 ? 8.0 : 0),
          height: 8,
          width: currentIndex == index ? 32 : 8,
          decoration: BoxDecoration(
            color: currentIndex == index
                ? AppColors.primary
                : AppColors.warmGray,
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),
    );
  }
}
