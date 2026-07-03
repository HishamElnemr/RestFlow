import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/owner_dashboard_page_body.dart';

class OwnerDashboardPage extends StatelessWidget {
  const OwnerDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: OwnerDashboardPageBody(),
      ),
    );
  }
}
