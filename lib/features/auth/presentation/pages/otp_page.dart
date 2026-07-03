import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/otp_page_body.dart';

class OtpPage extends StatelessWidget {
  final String email;
  final bool isResetPassword;

  const OtpPage({
    super.key,
    required this.email,
    this.isResetPassword = false,
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
        child: OtpPageBody(
          email: email,
          isResetPassword: isResetPassword,
        ),
      ),
    );
  }
}
