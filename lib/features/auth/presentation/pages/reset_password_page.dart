import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/reset_password_page_body.dart';

class ResetPasswordPage extends StatelessWidget {
  final String email;
  final String otpCode;

  const ResetPasswordPage({
    super.key,
    required this.email,
    required this.otpCode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.darkNavy),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: ResetPasswordPageBody(
          email: email,
          otpCode: otpCode,
        ),
      ),
    );
  }
}
