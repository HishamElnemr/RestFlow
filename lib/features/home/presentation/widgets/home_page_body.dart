import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/getit_services.dart';
import '../../../../core/services/secure_storage_service.dart';
import '../../../../core/routes/routes_name.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/restflow_logo.dart';
import '../../../auth/presentation/cubit/auth_session/auth_session_cubit.dart';
import '../../../auth/presentation/cubit/auth_session/auth_session_state.dart';
import '../../../../features/auth/domain/entities/logout_request_entity.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  Future<void> _logout(BuildContext context) async {
    // Clear local tokens immediately
    await getIt<SecureStorageService>().deleteTokens();

    // Call server logout (fire and forget, don't block navigation)
    if (context.mounted) {
      context.read<AuthSessionCubit>().logout(
        const LogoutRequestEntity(refreshToken: ''),
      );
      Navigator.pushNamedAndRemoveUntil(
        context,
        RoutesName.login,
        (route) => false,
      );
    }
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
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const RestflowLogo(),
                const SizedBox(height: 32),
                const Text(
                  'Welcome, Owner!',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: AppColors.darkNavy,
                    fontFamily: 'Inter',
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                const Text(
                  'You are now logged in to the Owner Dashboard.',
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColors.mutedGray,
                    fontFamily: 'Inter',
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 56),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => _logout(context),
                    icon: const Icon(Icons.logout, color: AppColors.error),
                    label: const Text(
                      'Logout',
                      style: TextStyle(
                        color: AppColors.error,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.error),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
