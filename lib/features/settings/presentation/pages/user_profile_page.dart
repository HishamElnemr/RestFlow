import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/getit_services.dart';
import '../../../../core/theme/app_colors.dart';
import '../cubit/user_profile_settings/user_profile_settings_cubit.dart';
import '../widgets/user_profile_page_body.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<UserProfileSettingsCubit>()..fetchUserProfile(),
      child: const Scaffold(
        backgroundColor: AppColors.backgroundLight,
        body: SafeArea(
          child: UserProfilePageBody(),
        ),
      ),
    );
  }
}
