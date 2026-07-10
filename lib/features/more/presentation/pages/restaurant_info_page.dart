import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_flow/features/settings/presentation/cubit/restaurant_settings/restaurant_settings_cubit.dart';

import '../../../../core/services/getit_services.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/restaurant_info_page_body.dart';

class RestaurantInfoPage extends StatelessWidget {
  const RestaurantInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<RestaurantSettingsCubit>()..fetchRestaurantSettings(),
      child: const Scaffold(
        backgroundColor: AppColors.backgroundLight,
        body: SafeArea(
          child: RestaurantInfoPageBody(),
        ),
      ),
    );
  }
}
