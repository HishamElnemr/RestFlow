import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_flow/features/auth/domain/entities/reset_password_request_entity.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_primary_button.dart';
import '../cubit/reset_password/reset_password_cubit.dart';
import '../cubit/reset_password/reset_password_state.dart';
import 'reset_password_form_fields.dart';
import 'reset_password_header.dart';
import '../../../../core/routes/routes_name.dart';

class ResetPasswordPageBody extends StatefulWidget {
  final String email;
  final String otpCode;

  const ResetPasswordPageBody({
    super.key,
    required this.email,
    required this.otpCode,
  });

  @override
  State<ResetPasswordPageBody> createState() => _ResetPasswordPageBodyState();
}

class _ResetPasswordPageBodyState extends State<ResetPasswordPageBody> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<ResetPasswordCubit>().resetPassword(
        ResetPasswordRequestEntity(
          identifier: widget.email,
          otpCode: widget.otpCode,
          newPassword: _passwordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const ResetPasswordHeader(),
              const SizedBox(height: 48),
              ResetPasswordFormFields(
                passwordController: _passwordController,
                confirmPasswordController: _confirmPasswordController,
              ),
              const SizedBox(height: 48),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.failure.message),
              backgroundColor: AppColors.error,
            ),
          );
        } else if (state is ResetPasswordSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Password reset successfully! You can now login.'),
              backgroundColor: AppColors.successBright,
            ),
          );
          // Navigate to Login and clear stack
          Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesName.login,
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is ResetPasswordLoading;
        return CustomPrimaryButton(
          text: 'Reset Password',
          isLoading: isLoading,
          onPressed: _onSubmit,
        );
      },
    );
  }
}
