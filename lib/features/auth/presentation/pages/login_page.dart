import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../widgets/login_page_body.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: const SafeArea(child: LoginPageBody()),
    );
  }
}
