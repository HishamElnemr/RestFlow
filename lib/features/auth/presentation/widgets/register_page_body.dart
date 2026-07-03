import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_flow/core/routes/routes_name.dart';
import 'package:rest_flow/features/auth/domain/entities/register_request_entity.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_primary_button.dart';
import '../../../../core/widgets/restflow_logo.dart';
import '../cubit/register/register_cubit.dart';
import '../cubit/register/register_state.dart';
import 'register_appbar.dart';
import 'register_footer_links.dart';
import 'register_form_fields.dart';

class RegisterPageBody extends StatefulWidget {
  const RegisterPageBody({super.key});

  @override
  State<RegisterPageBody> createState() => _RegisterPageBodyState();
}

class _RegisterPageBodyState extends State<RegisterPageBody> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onSignUp() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<RegisterCubit>().register(
        RegisterRequestEntity(
          fullName: _fullNameController.text.trim(),
          email: _emailController.text.trim(),
          phoneNumber: '+20${_phoneController.text.trim()}',
          password: _passwordController.text,
          confirmPassword: _confirmPasswordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(child: RestflowLogo()),
              const SizedBox(height: 8),
              const RegisterAppbar(),
              const SizedBox(height: 32),
              RegisterFormFields(
                fullNameController: _fullNameController,
                emailController: _emailController,
                phoneController: _phoneController,
                passwordController: _passwordController,
                confirmPasswordController: _confirmPasswordController,
              ),
              const SizedBox(height: 32),
              _buildSubmitButton(),
              const SizedBox(height: 32),
              RegisterFooterLinks(
                onSignInPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.failure.message),
              backgroundColor: AppColors.error,
            ),
          );
        } else if (state is RegisterSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Registration Successful!'),
              backgroundColor: AppColors.successBright,
            ),
          );
          Navigator.pushNamed(
            context,
            RoutesName.otp,
            arguments: _emailController.text.trim(),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is RegisterLoading;
        return CustomPrimaryButton(
          text: 'Sign up',
          isLoading: isLoading,
          onPressed: _onSignUp,
        );
      },
    );
  }
}
