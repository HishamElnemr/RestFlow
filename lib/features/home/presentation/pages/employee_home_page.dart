import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/routes/routes_name.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../auth/domain/entities/logout_request_entity.dart';
import '../../../auth/presentation/cubit/auth_session/auth_session_cubit.dart';
import '../../../auth/presentation/cubit/auth_session/auth_session_state.dart';

class EmployeeHomePage extends StatelessWidget {
  const EmployeeHomePage({super.key});

  void _logout(BuildContext context) {
    context.read<AuthSessionCubit>().logout(
      const LogoutRequestEntity(refreshToken: ''),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthSessionCubit, AuthSessionState>(
      listener: (context, state) {
        if (state is AuthSessionLogoutSuccess) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesName.login,
            (route) => false,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Employee Dashboard'),
          actions: [
            IconButton(
              onPressed: () => _logout(context),
              icon: const Icon(Icons.logout, color: AppColors.error),
              tooltip: 'Logout',
            ),
          ],
        ),
        body: const Center(
          child: Text('Welcome, Employee! This is your dashboard.'),
        ),
      ),
    );
  }
}
