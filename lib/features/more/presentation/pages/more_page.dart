import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../widgets/more_page_body.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: MorePageBody(),
      ),
    );
  }
}
