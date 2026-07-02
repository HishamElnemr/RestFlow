import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import '../../../../core/theme/app_colors.dart';

class OtpPinInput extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onCompleted;
  final Function(String)? onChanged;
  final bool hasError;
  final bool isSuccess;

  const OtpPinInput({
    super.key,
    required this.controller,
    this.onCompleted,
    this.onChanged,
    this.hasError = false,
    this.isSuccess = false,
  });

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 64,
      textStyle: const TextStyle(
        fontSize: 24,
        color: AppColors.darkNavy,
        fontWeight: FontWeight.w600,
        fontFamily: 'Inter',
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.borderLight),
        borderRadius: BorderRadius.circular(12),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppColors.primary, width: 2),
      borderRadius: BorderRadius.circular(12),
    );

    var currentDefaultTheme = defaultPinTheme;
    var currentSubmittedTheme = focusedPinTheme;

    if (hasError) {
      currentDefaultTheme = defaultPinTheme.copyDecorationWith(
        color: AppColors.errorBg,
        border: Border.all(color: AppColors.error, width: 2),
      );
      currentSubmittedTheme = currentDefaultTheme;
    } else if (isSuccess) {
      currentDefaultTheme = defaultPinTheme.copyDecorationWith(
        color: AppColors.successBg,
        border: Border.all(color: AppColors.successBright, width: 2),
      );
      currentSubmittedTheme = currentDefaultTheme;
    }

    return Pinput(
      length: 6,
      controller: controller,
      defaultPinTheme: currentDefaultTheme,
      focusedPinTheme: hasError || isSuccess ? currentDefaultTheme : focusedPinTheme,
      submittedPinTheme: currentSubmittedTheme,
      showCursor: true,
      onCompleted: onCompleted,
      onChanged: onChanged,
      keyboardType: TextInputType.number,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
    );
  }
}
