import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/getit_services.dart';
import '../../../../core/theme/app_colors.dart';
import '../cubit/ai_dashboard/ai_dashboard_cubit.dart';
import '../widgets/ai_dashboard_page_body.dart';

class AiDashboardPage extends StatelessWidget {
  const AiDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AiDashboardCubit>(),
      child: const Scaffold(
        backgroundColor: AppColors.backgroundLight,
        body: SafeArea(child: AiDashboardPageBody()),
      ),
    );
  }
}
