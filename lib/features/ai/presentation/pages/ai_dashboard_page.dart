import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/getit_services.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../cubit/ai_dashboard/ai_dashboard_cubit.dart';
import '../widgets/ai_dashboard_page_body.dart';

class AiDashboardPage extends StatelessWidget {
  const AiDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AiDashboardCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundLight,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Text(
            'AI Co-Pilot',
            style: AppStyles.heading3SemiBold18(context).copyWith(
              color: AppColors.darkNavy,
              fontSize: 22,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.18),
            child: Container(color: AppColors.warmGray, height: 1.18),
          ),
        ),
        body: const SafeArea(child: AiDashboardPageBody()),
      ),
    );
  }
}
