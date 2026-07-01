import 'package:flutter/material.dart';

import '../../../../core/routes/routes_name.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/restflow_animated_logo.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: RestflowAnimatedLogo(
          onAnimationComplete: () {
            Future.delayed(const Duration(milliseconds: 800), () {
              if (context.mounted) {
                Navigator.pushReplacementNamed(
                  context,
                  RoutesName.onboarding,
                );
              }
            });
          },
        ),
      ),
    );
  }
}
