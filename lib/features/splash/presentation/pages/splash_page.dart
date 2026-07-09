import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routes/routes_name.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/restflow_animated_logo.dart';
import '../../../auth/presentation/cubit/auth_session/auth_session_cubit.dart';
import '../../../auth/presentation/cubit/auth_session/auth_session_state.dart';
import '../widgets/splash_loading_indicator.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _logoAnimationDone = false;
  bool _authCheckDone = false;
  AuthSessionState? _pendingState;

  @override
  void initState() {
    super.initState();
    context.read<AuthSessionCubit>().checkAuthStatus();
  }

  void _onLogoAnimationComplete() {
    setState(() => _logoAnimationDone = true);
    if (_authCheckDone && _pendingState != null) {
      _navigate(_pendingState!);
    }
  }

  void _onAuthStateReceived(AuthSessionState state) {
    _authCheckDone = true;
    _pendingState = state;
    if (_logoAnimationDone) {
      _navigate(state);
    }
  }

  void _navigate(AuthSessionState state) {
    if (state is AuthSessionAuthenticated) {
      final isOwner = state.role == 'Owner' || state.role == 'SuperAdmin';
      Navigator.pushReplacementNamed(
        context,
        isOwner ? RoutesName.layout : RoutesName.employeeHome,
      );
    } else if (state is AuthSessionUnauthenticated) {
      Navigator.pushReplacementNamed(context, RoutesName.onboarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthSessionCubit, AuthSessionState>(
      listener: (context, state) {
        if (state is AuthSessionAuthenticated ||
            state is AuthSessionUnauthenticated) {
          _onAuthStateReceived(state);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Center(
                child: RestflowAnimatedLogo(
                  onAnimationComplete: _onLogoAnimationComplete,
                ),
              ),
              const Spacer(),
              const SplashLoadingIndicator(),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}
