import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_flow/features/auth/domain/entities/forgot_password_request_entity.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_primary_button.dart';
import '../cubit/forgot_password/forgot_password_cubit.dart';
import '../cubit/forgot_password/forgot_password_state.dart';
import 'forgot_password_form_fields.dart';
import 'forgot_password_header.dart';
import '../../../../core/routes/routes_name.dart';

class ForgotPasswordPageBody extends StatefulWidget {
  const ForgotPasswordPageBody({super.key});

  @override
  State<ForgotPasswordPageBody> createState() => _ForgotPasswordPageBodyState();
}

class _ForgotPasswordPageBodyState extends State<ForgotPasswordPageBody> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<ForgotPasswordCubit>().forgotPassword(
        ForgotPasswordRequestEntity(
          identifier: _emailController.text.trim(),
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
              const ForgotPasswordHeader(),
              const SizedBox(height: 48),
              ForgotPasswordFormFields(
                emailController: _emailController,
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
    return BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
      listener: (context, state) {
        if (state is ForgotPasswordFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.failure.message),
              backgroundColor: AppColors.error,
            ),
          );
        } else if (state is ForgotPasswordSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Password reset link sent to your email!'),
              backgroundColor: AppColors.successBright,
            ),
          );
          // Navigate to OTP
          Navigator.pushNamed(
            context,
            RoutesName.otp,
            arguments: {
              'email': _emailController.text.trim(),
              'isResetPassword': true,
            },
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is ForgotPasswordLoading;
        return CustomPrimaryButton(
          text: 'Send Reset Link',
          isLoading: isLoading,
          onPressed: _onSubmit,
        );
      },
    );
  }
}
