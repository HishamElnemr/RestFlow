import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_flow/features/reports/presentation/cubit/reports/reports_cubit.dart';
import '../../../../core/services/getit_services.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/owner_dashboard_page_body.dart';

class OwnerDashboardPage extends StatelessWidget {
  const OwnerDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ReportsCubit>(),
      child: const Scaffold(
        backgroundColor: AppColors.backgroundLight,
        body: SafeArea(
          child: OwnerDashboardPageBody(),
        ),
      ),
    );
  }
}
