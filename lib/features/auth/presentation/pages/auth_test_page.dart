import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_styles.dart';
import '../../domain/entities/channel_type.dart';
import '../../domain/entities/login_request_entity.dart';
import '../../domain/entities/register_request_entity.dart';
import '../../domain/entities/resend_otp_request_entity.dart';
import '../../domain/entities/verify_otp_request_entity.dart';
import '../cubit/login/login_cubit.dart';
import '../cubit/login/login_state.dart';
import '../cubit/otp/otp_cubit.dart';
import '../cubit/otp/otp_state.dart';
import '../cubit/register/register_cubit.dart';
import '../cubit/register/register_state.dart';

class AuthTestPage extends StatefulWidget {
  const AuthTestPage({super.key});

  @override
  State<AuthTestPage> createState() => _AuthTestPageState();
}

class _AuthTestPageState extends State<AuthTestPage> {
  final _loginEmailController = TextEditingController();
  final _loginPasswordController = TextEditingController();

  final _registerNameController = TextEditingController();
  final _registerEmailController = TextEditingController();
  final _registerPhoneController = TextEditingController();
  final _registerPasswordController = TextEditingController();
  final _registerConfirmController = TextEditingController();

  final _otpEmailController = TextEditingController();
  final _otpCodeController = TextEditingController();

  final _resendEmailController = TextEditingController();

  ChannelType _verifyChannel = ChannelType.email;
  ChannelType _resendChannel = ChannelType.email;

  @override
  void dispose() {
    _loginEmailController.dispose();
    _loginPasswordController.dispose();
    _registerNameController.dispose();
    _registerEmailController.dispose();
    _registerPhoneController.dispose();
    _registerPasswordController.dispose();
    _registerConfirmController.dispose();
    _otpEmailController.dispose();
    _otpCodeController.dispose();
    _resendEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Auth Sandbox'),
        backgroundColor: colorScheme.surface,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [colorScheme.surface, colorScheme.surfaceContainerHighest],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text('Quick Auth Tests', style: AppStyles.title(context)),
              const SizedBox(height: 16),
              _sectionCard(
                context,
                title: 'Register',
                child: _registerSection(context),
              ),
              const SizedBox(height: 16),
              _sectionCard(
                context,
                title: 'Login',
                child: _loginSection(context),
              ),
              const SizedBox(height: 16),
              _sectionCard(context, title: 'OTP', child: _otpSection(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionCard(
    BuildContext context, {
    required String title,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppStyles.section(context)),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _registerSection(BuildContext context) {
    return Column(
      children: [
        _field(
          context,
          controller: _registerNameController,
          label: 'Full name',
        ),
        const SizedBox(height: 12),
        _field(context, controller: _registerEmailController, label: 'Email'),
        const SizedBox(height: 12),
        _field(context, controller: _registerPhoneController, label: 'Phone'),
        const SizedBox(height: 12),
        _field(
          context,
          controller: _registerPasswordController,
          label: 'Password',
          obscureText: true,
        ),
        const SizedBox(height: 12),
        _field(
          context,
          controller: _registerConfirmController,
          label: 'Confirm password',
          obscureText: true,
        ),
        const SizedBox(height: 12),
        BlocBuilder<RegisterCubit, RegisterState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: state is RegisterLoading
                      ? null
                      : () => _onRegisterPressed(context),
                  child: state is RegisterLoading
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Register'),
                ),
                const SizedBox(height: 8),
                _stateMessage(context, _registerMessage(state)),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _loginSection(BuildContext context) {
    return Column(
      children: [
        _field(
          context,
          controller: _loginEmailController,
          label: 'Email or phone',
        ),
        const SizedBox(height: 12),
        _field(
          context,
          controller: _loginPasswordController,
          label: 'Password',
          obscureText: true,
        ),
        const SizedBox(height: 12),
        BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: state is LoginLoading
                      ? null
                      : () => _onLoginPressed(context),
                  child: state is LoginLoading
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Login'),
                ),
                const SizedBox(height: 8),
                _stateMessage(context, _loginMessage(state)),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _otpSection(BuildContext context) {
    return Column(
      children: [
        _field(context, controller: _otpEmailController, label: 'Email'),
        const SizedBox(height: 12),
        _field(context, controller: _otpCodeController, label: 'OTP code'),
        const SizedBox(height: 12),
        _channelPicker(
          context,
          label: 'Verify channel',
          value: _verifyChannel,
          onChanged: (value) => setState(() => _verifyChannel = value),
        ),
        const SizedBox(height: 12),
        _channelPicker(
          context,
          label: 'Resend channel',
          value: _resendChannel,
          onChanged: (value) => setState(() => _resendChannel = value),
        ),
        const SizedBox(height: 12),
        _field(
          context,
          controller: _resendEmailController,
          label: 'Resend email',
        ),
        const SizedBox(height: 12),
        BlocBuilder<OtpCubit, OtpState>(
          builder: (context, state) {
            final isBusy = state is OtpLoading;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: isBusy ? null : () => _onVerifyOtpPressed(context),
                  child: state is OtpLoading && state.action == OtpAction.verify
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Verify OTP'),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: isBusy ? null : () => _onResendOtpPressed(context),
                  child: state is OtpLoading && state.action == OtpAction.resend
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Resend OTP'),
                ),
                const SizedBox(height: 8),
                _stateMessage(context, _otpMessage(state)),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _field(
    BuildContext context, {
    required TextEditingController controller,
    required String label,
    bool obscureText = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppStyles.label(context)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            filled: true,
            fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _channelPicker(
    BuildContext context, {
    required String label,
    required ChannelType value,
    required ValueChanged<ChannelType> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppStyles.label(context)),
        const SizedBox(height: 6),
        DropdownButtonFormField<ChannelType>(
          value: value,
          items: ChannelType.values
              .map(
                (type) => DropdownMenuItem(
                  value: type,
                  child: Text(type.name.toUpperCase()),
                ),
              )
              .toList(),
          onChanged: (value) {
            if (value != null) {
              onChanged(value);
            }
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _stateMessage(BuildContext context, String message) {
    if (message.isEmpty) {
      return const SizedBox.shrink();
    }
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(message, style: AppStyles.body(context)),
    );
  }

  String _registerMessage(RegisterState state) {
    if (state is RegisterFailure) {
      return state.failure.message;
    }
    if (state is RegisterSuccess) {
      return state.response.message ?? 'Registration completed.';
    }
    return '';
  }

  String _loginMessage(LoginState state) {
    if (state is LoginFailure) {
      return state.failure.message;
    }
    if (state is LoginSuccess) {
      return state.response.message ?? 'Login completed.';
    }
    return '';
  }

  String _otpMessage(OtpState state) {
    if (state is OtpFailure) {
      return state.failure.message;
    }
    if (state is OtpSuccess) {
      return state.response.message ?? 'OTP updated.';
    }
    return '';
  }

  void _onRegisterPressed(BuildContext context) {
    context.read<RegisterCubit>().register(
      RegisterRequestEntity(
        fullName: _registerNameController.text.trim(),
        email: _registerEmailController.text.trim(),
        phoneNumber: _registerPhoneController.text.trim(),
        password: _registerPasswordController.text,
        confirmPassword: _registerConfirmController.text,
      ),
    );
  }

  void _onLoginPressed(BuildContext context) {
    context.read<LoginCubit>().login(
      LoginRequestEntity(
        email: _loginEmailController.text.trim(),
        password: _loginPasswordController.text,
      ),
    );
  }

  void _onVerifyOtpPressed(BuildContext context) {
    context.read<OtpCubit>().verifyOtp(
      VerifyOtpRequestEntity(
        email: _otpEmailController.text.trim(),
        code: _otpCodeController.text.trim(),
        channel: _verifyChannel,
      ),
    );
  }

  void _onResendOtpPressed(BuildContext context) {
    context.read<OtpCubit>().resendOtp(
      ResendOtpRequestEntity(
        email: _resendEmailController.text.trim(),
        channel: _resendChannel,
      ),
    );
  }
}
