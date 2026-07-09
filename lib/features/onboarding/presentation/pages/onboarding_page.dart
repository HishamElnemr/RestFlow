import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../widgets/onboarding_page_body.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: OnboardingPageBody(),
      ),
    );
  }
}
