import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/getit_services.dart';
import '../../../../core/services/secure_storage_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../auth/domain/entities/logout_request_entity.dart';
import '../../../auth/presentation/cubit/auth_session/auth_session_cubit.dart';

class OwnerDashboardHeader extends StatelessWidget {
  const OwnerDashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'The Golden Spool',
          style: TextStyle(
            color: AppColors.darkNavy,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
        GestureDetector(
          onTap: () async {
            final secureStorage = getIt<SecureStorageService>();
            final refreshToken = await secureStorage.readRefreshToken() ?? '';
            if (context.mounted) {
              context.read<AuthSessionCubit>().logout(
                    LogoutRequestEntity(refreshToken: refreshToken),
                  );
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.error,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  //color: AppColors.error.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.logout_rounded,
                  color: AppColors.backgroundLight,
                  size: 16,
                ),
                SizedBox(width: 4),
                Text(
                  'Logout',
                  style: TextStyle(
                    color: AppColors.backgroundLight,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
