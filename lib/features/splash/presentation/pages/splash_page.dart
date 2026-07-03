import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routes/routes_name.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/restflow_animated_logo.dart';
import '../../../auth/presentation/cubit/auth_session/auth_session_cubit.dart';
import '../../../auth/presentation/cubit/auth_session/auth_session_state.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthSessionCubit, AuthSessionState>(
      listener: (context, state) {
        if (state is AuthSessionAuthenticated) {
          final isOwner = state.role == 'Owner' || state.role == 'SuperAdmin';
          Navigator.pushReplacementNamed(
            context,
            isOwner ? RoutesName.home : RoutesName.employeeHome,
          );
        } else if (state is AuthSessionUnauthenticated) {
          Navigator.pushReplacementNamed(context, RoutesName.onboarding);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Center(
          child: RestflowAnimatedLogo(
            onAnimationComplete: () {
              // After animation, check token
              context.read<AuthSessionCubit>().checkAuthStatus();
            },
          ),
        ),
      ),
    );
  }
}
