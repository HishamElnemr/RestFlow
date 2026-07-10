import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../widgets/notifications_page_body.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: NotificationsPageBody(),
      ),
    );
  }
}
