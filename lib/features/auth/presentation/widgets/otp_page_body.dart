import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_flow/features/auth/domain/entities/channel_type.dart';
import 'package:rest_flow/features/auth/domain/entities/forgot_password_request_entity.dart';
import 'package:rest_flow/features/auth/domain/entities/resend_otp_request_entity.dart';
import 'package:rest_flow/features/auth/domain/entities/verify_otp_request_entity.dart';

import '../../../../core/routes/routes_name.dart';
import '../../../../core/services/getit_services.dart';
import '../../../../core/services/secure_storage_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_primary_button.dart';
import '../cubit/otp/otp_cubit.dart';
import '../cubit/otp/otp_state.dart';
import 'otp_header.dart';
import 'otp_pin_input.dart';

class OtpPageBody extends StatefulWidget {
  final String email;
  final bool isResetPassword;

  const OtpPageBody({
    super.key,
    required this.email,
    this.isResetPassword = false,
  });

  @override
  State<OtpPageBody> createState() => _OtpPageBodyState();
}

class _OtpPageBodyState extends State<OtpPageBody> {
  final _pinController = TextEditingController();

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  void _onVerify() {
    if (_pinController.text.length == 6) {
      context.read<OtpCubit>().verifyOtp(
        VerifyOtpRequestEntity(
          email: widget.email,
          code: _pinController.text,
          channel: ChannelType.email,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid 6-digit code')),
      );
    }
  }

  void _onResend() {
    if (widget.isResetPassword) {
      // In the forgot-password flow the email is already verified,
      // so we re-trigger the forgot-password endpoint to get a new OTP.
      context.read<OtpCubit>().resendForgotPassword(
        ForgotPasswordRequestEntity(identifier: widget.email),
      );
    } else {
      context.read<OtpCubit>().resendOtp(
        ResendOtpRequestEntity(
          email: widget.email,
          channel: ChannelType.email,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            OtpHeader(email: widget.email),
            const SizedBox(height: 48),
            BlocBuilder<OtpCubit, OtpState>(
              builder: (context, state) {
                final hasError =
                    state is OtpFailure && state.action == OtpAction.verify;
                final isSuccess =
                    state is OtpSuccess && state.action == OtpAction.verify;

                return Center(
                  child: OtpPinInput(
                    controller: _pinController,
                    hasError: hasError,
                    isSuccess: isSuccess,
                    onChanged: (val) {
                      if (hasError || isSuccess) {
                        context.read<OtpCubit>().reset();
                      }
                    },
                    onCompleted: (pin) => _onVerify(),
                  ),
                );
              },
            ),
            const SizedBox(height: 48),
            _buildSubmitButton(),
            const SizedBox(height: 32),
            _buildResendButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return BlocConsumer<OtpCubit, OtpState>(
      listenWhen: (previous, current) {
        if (current is OtpSuccess) return current.action == OtpAction.verify;
        if (current is OtpFailure) return current.action == OtpAction.verify;
        return false;
      },
      listener: (context, state) async{
        if (state is OtpFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.failure.message),
              backgroundColor: AppColors.error,
            ),
          );
        } else if (state is OtpSuccess) {
          // Save tokens if returned by backend (registration flow)
          final response = state.response;
          if (response.token != null) {
            await getIt<SecureStorageService>().saveAccessToken(response.token!);
          }
          if (response.refreshToken != null) {
            await getIt<SecureStorageService>().saveRefreshToken(response.refreshToken!);
          }

          if (!context.mounted) return;

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Verification Successful!'),
              backgroundColor: AppColors.successBright,
            ),
          );

          if (widget.isResetPassword) {
            Navigator.pushNamed(
              context,
              RoutesName.resetPassword,
              arguments: {
                'email': widget.email,
                'otpCode': _pinController.text,
              },
            );
          } else {
            // Registration success — go to Home
            Navigator.pushNamedAndRemoveUntil(
              context,
              RoutesName.home,
              (route) => false,
            );
          }
        }
      },
      buildWhen: (previous, current) {
        if (current is OtpInitial) return true;
        if (current is OtpLoading) return current.action == OtpAction.verify;
        if (current is OtpSuccess) return current.action == OtpAction.verify;
        if (current is OtpFailure) return current.action == OtpAction.verify;
        return false;
      },
      builder: (context, state) {
        final isLoading = state is OtpLoading && state.action == OtpAction.verify;
        return CustomPrimaryButton(
          text: 'Verify',
          isLoading: isLoading,
          onPressed: _onVerify,
        );
      },
    );
  }

  Widget _buildResendButton() {
    return BlocConsumer<OtpCubit, OtpState>(
      listenWhen: (previous, current) {
        if (current is OtpSuccess) return current.action == OtpAction.resend;
        if (current is OtpFailure) return current.action == OtpAction.resend;
        return false;
      },
      listener: (context, state) {
        if (state is OtpFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.failure.message),
              backgroundColor: AppColors.error,
            ),
          );
        } else if (state is OtpSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Code resent successfully!'),
              backgroundColor: AppColors.successBright,
            ),
          );
        }
      },
      buildWhen: (previous, current) {
        if (current is OtpInitial) return true;
        if (current is OtpLoading) return current.action == OtpAction.resend;
        if (current is OtpSuccess) return current.action == OtpAction.resend;
        if (current is OtpFailure) return current.action == OtpAction.resend;
        return false;
      },
      builder: (context, state) {
        final isLoading = state is OtpLoading && state.action == OtpAction.resend;
        return Center(
          child: isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : GestureDetector(
                  onTap: _onResend,
                  child: const Text(
                    "Didn't receive the code? Resend",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
        );
      },
    );
  }
}
