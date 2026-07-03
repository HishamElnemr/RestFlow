import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../widgets/register_page_body.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: const SafeArea(
        child: RegisterPageBody(),
      ),
    );
  }
}
