import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_flow/features/auth/domain/entities/login_request_entity.dart';
import '../../../../core/routes/routes_name.dart';
import '../../../../core/services/firebase_notification_service.dart';
import '../../../../core/services/getit_services.dart';
import '../../../../core/services/secure_storage_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/jwt_utils.dart';
import '../../../../core/widgets/custom_primary_button.dart';
import '../../../../core/widgets/restflow_logo.dart';
import '../../../../features/notification/domain/repositories/notifications_repository.dart';
import '../cubit/login/login_cubit.dart';
import '../cubit/login/login_state.dart';
import 'login_appbar.dart';
import 'login_forgot_password_link.dart';
import 'login_form_fields.dart';

class LoginPageBody extends StatefulWidget {
  const LoginPageBody({super.key});

  @override
  State<LoginPageBody> createState() => _LoginPageBodyState();
}

class _LoginPageBodyState extends State<LoginPageBody> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSignIn() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<LoginCubit>().login(
            LoginRequestEntity(
              email: _emailController.text.trim(),
              password: _passwordController.text,
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
              const LoginAppbar(),
              const SizedBox(height: 32),
              LoginFormFields(
                emailController: _emailController,
                passwordController: _passwordController,
              ),
              const SizedBox(height: 16),
              LoginForgotPasswordLink(
                onPressed: () =>
                    Navigator.pushNamed(context, RoutesName.forgotPassword),
              ),
              const SizedBox(height: 32),
              _buildSubmitButton(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) async {
        if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.failure.message),
              backgroundColor: AppColors.error,
            ),
          );
        } else if (state is LoginSuccess) {
          final response = state.response;
          if (response.token != null) {
            await getIt<SecureStorageService>()
                .saveAccessToken(response.token!);
          }
          if (response.refreshToken != null) {
            await getIt<SecureStorageService>()
                .saveRefreshToken(response.refreshToken!);
          }
          await FirebaseNotificationService().registerTokenAfterLogin(
            getIt<NotificationsRepository>(),
          );
          if (context.mounted) {
            final role = response.token != null
                ? JwtUtils.getRole(response.token!)
                : null;
            final isOwner = role == 'Owner' || role == 'SuperAdmin';

            Navigator.pushNamedAndRemoveUntil(
              context,
              isOwner ? RoutesName.layout : RoutesName.employeeHome,
              (route) => false,
            );
          }
        }
      },
      builder: (context, state) {
        final isLoading = state is LoginLoading;
        return CustomPrimaryButton(
          text: 'Sign in',
          isLoading: isLoading,
          onPressed: _onSignIn,
        );
      },
    );
  }
}
